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

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final currentSprintEntry = appState.currentSprintEntry;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        Text(
          'Agile Life',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Text(
          '오늘의 실행과 장기 목표 흐름을 한 번에 점검합니다.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이번 주 방향',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                currentSprintEntry?.sprint.objective ??
                    'Mock 데이터 기반 MVP 초안에서 핵심 흐름을 정리하는 단계입니다.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _SummaryStat(
                      label: 'XP',
                      value: '${appState.userStats.xp}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryStat(
                      label: 'Level',
                      value: 'Lv.${appState.userStats.level}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryStat(
                      label: 'Streak',
                      value: '${appState.userStats.streakDays}일',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton.tonalIcon(
                onPressed: () => context.pushNamed(AppRoutes.goalCreateName),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text('새 목표 추가'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '현재 진행 중인 스프린트',
          subtitle: '집중해야 할 가장 가까운 실행 블록',
        ),
        const SizedBox(height: 12),
        if (currentSprintEntry == null)
          const EmptyStateCard(
            icon: Icons.bolt_rounded,
            title: '활성 스프린트가 없습니다',
            message: '새 목표를 만들면 첫 스프린트가 자동으로 생성됩니다.',
          )
        else
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        currentSprintEntry.sprint.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    StatusChip(
                      label:
                          sprintStatusLabel(currentSprintEntry.sprint.status),
                      tone: sprintStatusTone(currentSprintEntry.sprint.status),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  currentSprintEntry.goal.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                Text(currentSprintEntry.sprint.objective),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: currentSprintEntry.sprint.progress,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(999),
                ),
                const SizedBox(height: 12),
                Text(
                  '${(currentSprintEntry.sprint.progress * 100).round()}% 완료 · ${currentSprintEntry.sprint.completedTaskCount}/${currentSprintEntry.sprint.totalTaskCount}개 태스크',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppDateFormatter.range(
                    currentSprintEntry.sprint.startDate,
                    currentSprintEntry.sprint.endDate,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.sprintDetailName,
                      pathParameters: {
                        'sprintId': currentSprintEntry.sprint.id,
                      },
                    );
                  },
                  child: const Text('스프린트 상세 보기'),
                ),
              ],
            ),
          ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '오늘의 태스크',
          subtitle: '오늘 기준 due date로 잡힌 실행 항목',
        ),
        const SizedBox(height: 12),
        if (appState.todayTasks.isEmpty)
          const EmptyStateCard(
            icon: Icons.today_rounded,
            title: '오늘 등록된 태스크가 없습니다',
            message: '다른 스프린트에서 오늘 마감 Task를 추가해 보세요.',
          )
        else
          ...appState.todayTasks.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskTile(
                title: entry.task.title,
                subtitle: '${entry.goal.title} · ${entry.sprint.title}',
                value: entry.task.isCompleted,
                trailing: '+${entry.task.xpReward} XP',
                onChanged: (_) {
                  ref.read(appStateControllerProvider.notifier).toggleTask(
                        sprintId: entry.sprint.id,
                        taskId: entry.task.id,
                      );
                },
              ),
            ),
          ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '목표 진행률',
          subtitle: '장기 목표가 어느 정도 쪼개지고 실행되고 있는지 확인합니다.',
        ),
        const SizedBox(height: 12),
        ...appState.goals.map(
          (goal) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () {
                context.pushNamed(
                  AppRoutes.goalDetailName,
                  pathParameters: {'goalId': goal.id},
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          goal.title,
                          style: Theme.of(context).textTheme.titleMedium,
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
                    goal.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: goal.progress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '진행률 ${(goal.progress * 100).round()}% · 목표일 ${AppDateFormatter.fullDate(goal.targetDate)}',
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '최근 배지',
          subtitle: '작은 완료 경험을 꾸준히 쌓는 구조를 보여줍니다.',
        ),
        const SizedBox(height: 12),
        if (appState.recentBadges.isEmpty)
          const EmptyStateCard(
            icon: Icons.military_tech_rounded,
            title: '아직 획득한 배지가 없습니다',
            message: '목표 생성, 태스크 완료, 회고 작성으로 배지를 획득합니다.',
          )
        else
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: appState.recentBadges.take(2).map((badge) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(
                          badgeIconFor(badge.iconKey),
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              badge.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              badge.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
