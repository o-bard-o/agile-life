import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/models/goal_draft.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/utils/date_formatter.dart';

class GoalCreateScreen extends ConsumerStatefulWidget {
  const GoalCreateScreen({super.key});

  @override
  ConsumerState<GoalCreateScreen> createState() => _GoalCreateScreenState();
}

class _GoalCreateScreenState extends ConsumerState<GoalCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _category = '학습';
  DateTime _targetDate = DateTime.now().add(const Duration(days: 60));

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 목표')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              '목표 만들기',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '달성하고 싶은 결과와 마감일을 정하세요.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '목표 제목',
                hintText: '예: 토익 900점 도전',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '목표 제목을 입력해 주세요.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: '목표 설명',
                hintText: '왜 이 목표가 중요한지, 어떤 방향으로 진행할지 적어 주세요.',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '목표 설명을 입력해 주세요.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: '카테고리'),
              items: const [
                DropdownMenuItem(value: '학습', child: Text('학습')),
                DropdownMenuItem(value: '건강', child: Text('건강')),
                DropdownMenuItem(value: '습관', child: Text('습관')),
                DropdownMenuItem(value: '커리어', child: Text('커리어')),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _category = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Theme.of(context).colorScheme.surface,
              title: const Text('목표일'),
              subtitle: Text(AppDateFormatter.fullDate(_targetDate)),
              trailing: const Icon(Icons.calendar_month_rounded),
              onTap: _pickTargetDate,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.add_task_rounded),
              label: const Text('목표 저장'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTargetDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _targetDate = selectedDate;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(appStateControllerProvider.notifier).addGoal(
          GoalDraft(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            category: _category,
            targetDate: _targetDate,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('새 목표를 추가했습니다.')),
    );

    context.go(AppRoutes.goalsPath);
  }
}
