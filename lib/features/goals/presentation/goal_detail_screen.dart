import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/status_presenter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_chip.dart';

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({
    super.key,
    required this.goalId,
  });

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final goal = appState.goalById(goalId);
    final colorScheme = Theme.of(context).colorScheme;

    if (goal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('목표')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: EmptyStateCard(
            icon: Icons.search_off_rounded,
            title: '목표를 찾을 수 없습니다',
            message: '삭제되었거나 아직 로드되지 않은 목표일 수 있습니다.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('목표')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        goal.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    StatusChip(
                      label: goalStatusLabel(goal.status),
                      tone: goalStatusTone(goal.status),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  goal.category,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                Text(goal.description),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    minHeight: 6,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${(goal.progress * 100).round()}% · ${AppDateFormatter.fullDate(goal.targetDate)}까지',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '마일스톤',
            subtitle: '중간 성과를 순서대로 확인합니다.',
          ),
          const SizedBox(height: 12),
          ...goal.milestones.map(
            (milestone) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      milestone.isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: milestone.isCompleted
                          ? colorScheme.primary
                          : colorScheme.outline,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            milestone.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(milestone.note),
                          const SizedBox(height: 6),
                          Text(
                            AppDateFormatter.fullDate(milestone.dueDate),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '스프린트',
            subtitle: '실행 주기별 진행 상황입니다.',
          ),
          const SizedBox(height: 12),
          ...goal.sprints.map(
            (sprint) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            sprint.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        StatusChip(
                          label: sprintStatusLabel(sprint.status),
                          tone: sprintStatusTone(sprint.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(sprint.objective),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: sprint.progress,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${sprint.completedTaskCount}/${sprint.totalTaskCount}개 태스크 완료 · ${AppDateFormatter.range(sprint.startDate, sprint.endDate)}',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              context.pushNamed(
                                AppRoutes.sprintDetailName,
                                pathParameters: {'sprintId': sprint.id},
                              );
                            },
                            child: const Text('스프린트 열기'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
