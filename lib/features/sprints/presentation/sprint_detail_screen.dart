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
import '../../../shared/widgets/task_tile.dart';

class SprintDetailScreen extends ConsumerWidget {
  const SprintDetailScreen({
    super.key,
    required this.sprintId,
  });

  final String sprintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final sprint = appState.sprintById(sprintId);
    final goal = appState.goalForSprint(sprintId);
    final colorScheme = Theme.of(context).colorScheme;

    if (sprint == null || goal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('스프린트')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: EmptyStateCard(
            icon: Icons.search_off_rounded,
            title: '스프린트를 찾을 수 없습니다',
            message: '선택한 스프린트가 아직 생성되지 않았거나 이동되었습니다.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('스프린트')),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sprint.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            goal.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    StatusChip(
                      label: sprintStatusLabel(sprint.status),
                      tone: sprintStatusTone(sprint.status),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                  '${(sprint.progress * 100).round()}% 완료 · ${sprint.completedTaskCount}/${sprint.totalTaskCount}개 태스크',
                ),
                const SizedBox(height: 8),
                Text(
                  AppDateFormatter.range(sprint.startDate, sprint.endDate),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (sprint.completionBonusAwarded)
                      const StatusChip(
                        label: '완료율 보너스 획득',
                        tone: StatusTone.success,
                      ),
                    StatusChip(
                      label: 'XP 진행',
                      tone: StatusTone.info,
                    ),
                    StatusChip(
                      label: '회고 +30',
                      tone: StatusTone.warning,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '체크리스트',
            subtitle: '오늘 처리할 실행 항목입니다.',
          ),
          const SizedBox(height: 12),
          ...sprint.tasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskTile(
                title: task.title,
                subtitle:
                    '${task.note} · ${AppDateFormatter.monthDay(task.dueDate)}',
                value: task.isCompleted,
                trailing: '+${task.xpReward}',
                onChanged: (_) {
                  ref.read(appStateControllerProvider.notifier).toggleTask(
                        sprintId: sprint.id,
                        taskId: task.id,
                      );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회고',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  sprint.retrospectiveCompleted
                      ? '이미 회고가 작성되어 있습니다. 필요하면 내용을 수정할 수 있습니다.'
                      : '이번 실행에서 배운 점을 정리하고 다음 주 계획에 반영하세요.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.retrospectiveName,
                      pathParameters: {'sprintId': sprint.id},
                    );
                  },
                  child: Text(
                    sprint.retrospectiveCompleted ? '회고 수정하기' : '회고 작성하기',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
