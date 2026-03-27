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
        appBar: AppBar(title: const Text('스프린트 상세')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: EmptyStateCard(
            icon: Icons.search_off_rounded,
            title: '스프린트를 찾을 수 없습니다',
            message: '선택한 Sprint가 아직 생성되지 않았거나 이동되었습니다.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('스프린트 상세')),
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
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(999),
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
                      label: '태스크 완료 시 XP 획득',
                      tone: StatusTone.info,
                    ),
                    StatusChip(
                      label: '회고 작성 시 +30 XP',
                      tone: StatusTone.warning,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Task Checklist',
            subtitle: '완전한 백엔드 없이도 in-memory state로 체크 흐름이 동작합니다.',
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
                trailing: '+${task.xpReward} XP',
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
            color: colorScheme.tertiaryContainer.withValues(alpha: 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sprint Retrospective',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  sprint.retrospectiveCompleted
                      ? '이미 회고가 작성되어 있습니다. 필요하면 내용을 수정할 수 있습니다.'
                      : '잘한 점, 어려웠던 점, 유지할 점, 바꿀 점을 기록해 다음 Sprint 계획의 입력값으로 사용합니다.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onTertiaryContainer,
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
