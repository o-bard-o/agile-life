import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/retrospective_draft.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/empty_state_card.dart';

class RetrospectiveScreen extends ConsumerStatefulWidget {
  const RetrospectiveScreen({
    super.key,
    required this.sprintId,
  });

  final String sprintId;

  @override
  ConsumerState<RetrospectiveScreen> createState() =>
      _RetrospectiveScreenState();
}

class _RetrospectiveScreenState extends ConsumerState<RetrospectiveScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _wentWellController;
  late final TextEditingController _challengesController;
  late final TextEditingController _keepDoingController;
  late final TextEditingController _changeNextController;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(appStateControllerProvider);
    final existing = appState.retrospectiveBySprintId(widget.sprintId);

    _wentWellController = TextEditingController(text: existing?.wentWell ?? '');
    _challengesController =
        TextEditingController(text: existing?.challenges ?? '');
    _keepDoingController =
        TextEditingController(text: existing?.keepDoing ?? '');
    _changeNextController =
        TextEditingController(text: existing?.changeNext ?? '');
  }

  @override
  void dispose() {
    _wentWellController.dispose();
    _challengesController.dispose();
    _keepDoingController.dispose();
    _changeNextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateControllerProvider);
    final sprint = appState.sprintById(widget.sprintId);
    final goal = appState.goalForSprint(widget.sprintId);

    if (sprint == null || goal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('회고 작성')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: EmptyStateCard(
            icon: Icons.rate_review_outlined,
            title: '회고 대상을 찾을 수 없습니다',
            message: '선택한 Sprint가 아직 준비되지 않았습니다.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Retrospective')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sprint.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(goal.title),
                  const SizedBox(height: 12),
                  Text(
                    '이번 스프린트의 실행 경험을 기록해 다음 계획 품질을 높입니다.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _RetrospectiveField(
              controller: _wentWellController,
              label: '잘한 점',
              hintText: '예: 계획보다 늦지 않게 학습 시간을 확보했다.',
            ),
            const SizedBox(height: 16),
            _RetrospectiveField(
              controller: _challengesController,
              label: '어려웠던 점',
              hintText: '예: 퇴근 후 집중력이 떨어져 일부 태스크가 밀렸다.',
            ),
            const SizedBox(height: 16),
            _RetrospectiveField(
              controller: _keepDoingController,
              label: '유지할 점',
              hintText: '예: 아침 시간 블록을 먼저 확보하는 방식은 계속 유지한다.',
            ),
            const SizedBox(height: 16),
            _RetrospectiveField(
              controller: _changeNextController,
              label: '바꿀 점',
              hintText: '예: 스프린트 범위를 줄이고 회고 시점을 미리 캘린더에 넣는다.',
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () => _submit(goal.id),
              icon: const Icon(Icons.save_rounded),
              label: const Text('회고 저장'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(String goalId) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final wasCreated =
        ref.read(appStateControllerProvider.notifier).submitRetrospective(
              RetrospectiveDraft(
                goalId: goalId,
                sprintId: widget.sprintId,
                wentWell: _wentWellController.text.trim(),
                challenges: _challengesController.text.trim(),
                keepDoing: _keepDoingController.text.trim(),
                changeNext: _changeNextController.text.trim(),
              ),
            );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasCreated ? '회고를 저장하고 XP를 반영했습니다.' : '기존 회고를 업데이트했습니다.',
        ),
      ),
    );

    context.pop();
  }
}

class _RetrospectiveField extends StatelessWidget {
  const _RetrospectiveField({
    required this.controller,
    required this.label,
    required this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label 항목을 입력해 주세요.';
        }
        return null;
      },
    );
  }
}
