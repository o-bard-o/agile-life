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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오늘', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(
                    AppDateFormatter.fullDate(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            IconButton.filled(
              onPressed: () => context.pushNamed(AppRoutes.goalCreateName),
              icon: const Icon(Icons.add_rounded),
              tooltip: '목표 추가',
            ),
          ],
        ),
        const SizedBox(height: 20),
        AppCard(
          color: colorScheme.primary,
          borderColor: colorScheme.primary,
          padding: const EdgeInsets.all(20),
          child: currentSprintEntry == null
              ? _EmptyFocusPanel(
                  onCreateGoal: () =>
                      context.pushNamed(AppRoutes.goalCreateName),
                )
              : _FocusPanel(
                  title: currentSprintEntry.sprint.title,
                  goalTitle: currentSprintEntry.goal.title,
                  objective: currentSprintEntry.sprint.objective,
                  progress: currentSprintEntry.sprint.progress,
                  completedCount: currentSprintEntry.sprint.completedTaskCount,
                  totalCount: currentSprintEntry.sprint.totalTaskCount,
                  xp: appState.userStats.xp,
                  level: appState.userStats.level,
                  streakDays: appState.userStats.streakDays,
                  onOpenSprint: () {
                    context.pushNamed(
                      AppRoutes.sprintDetailName,
                      pathParameters: {
                        'sprintId': currentSprintEntry.sprint.id,
                      },
                    );
                  },
                ),
        ),
        const SizedBox(height: 28),
        const SectionHeader(
          title: '오늘 할 일',
          subtitle: '완료하면 바로 경험치가 반영됩니다.',
        ),
        const SizedBox(height: 12),
        if (appState.todayTasks.isEmpty)
          const EmptyStateCard(
            icon: Icons.today_rounded,
            title: '오늘 예정된 일이 없습니다',
            message: '새 목표를 만들거나 스프린트 일정을 조정해 보세요.',
          )
        else
          ...appState.todayTasks.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TaskTile(
                title: entry.task.title,
                subtitle: '${entry.goal.title} · ${entry.sprint.title}',
                value: entry.task.isCompleted,
                trailing: '+${entry.task.xpReward}',
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
        const SectionHeader(
          title: '목표 진행',
          subtitle: '현재 집중 중인 목표의 흐름입니다.',
        ),
        const SizedBox(height: 12),
        ...appState.goals.map(
          (goal) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: goal.progress,
                      minHeight: 6,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(goal.progress * 100).round()}% · ${AppDateFormatter.fullDate(goal.targetDate)}까지',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '최근 배지',
          subtitle: '${appState.recentBadges.length}개의 성취를 기록했습니다.',
        ),
        const SizedBox(height: 12),
        if (appState.recentBadges.isEmpty)
          const EmptyStateCard(
            icon: Icons.military_tech_rounded,
            title: '아직 배지가 없습니다',
            message: '목표를 만들고 첫 태스크를 완료해 보세요.',
          )
        else
          AppCard(
            child: Column(
              children: appState.recentBadges.take(2).map((badge) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Icon(
                        badgeIconFor(badge.iconKey),
                        size: 22,
                        color: colorScheme.onSurface,
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
                            const SizedBox(height: 2),
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

class _FocusPanel extends StatelessWidget {
  const _FocusPanel({
    required this.title,
    required this.goalTitle,
    required this.objective,
    required this.progress,
    required this.completedCount,
    required this.totalCount,
    required this.xp,
    required this.level,
    required this.streakDays,
    required this.onOpenSprint,
  });

  final String title;
  final String goalTitle;
  final String objective;
  final double progress;
  final int completedCount;
  final int totalCount;
  final int xp;
  final int level;
  final int streakDays;
  final VoidCallback onOpenSprint;

  @override
  Widget build(BuildContext context) {
    const foreground = Colors.white;
    final muted = Colors.white.withValues(alpha: 0.68);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '현재 스프린트',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: muted,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: foreground,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          goalTitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: muted),
        ),
        const SizedBox(height: 16),
        Text(
          objective,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: foreground,
              ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(foreground),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${(progress * 100).round()}% · $completedCount/$totalCount 완료',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _FocusMetric(label: 'XP', value: '$xp')),
            _FocusDivider(),
            Expanded(child: _FocusMetric(label: '레벨', value: 'Lv.$level')),
            _FocusDivider(),
            Expanded(child: _FocusMetric(label: '연속', value: '$streakDays일')),
          ],
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onOpenSprint,
          style: OutlinedButton.styleFrom(
            foregroundColor: foreground,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
          ),
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('스프린트 열기'),
        ),
      ],
    );
  }
}

class _EmptyFocusPanel extends StatelessWidget {
  const _EmptyFocusPanel({required this.onCreateGoal});

  final VoidCallback onCreateGoal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '시작할 스프린트가 없습니다',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '새 목표를 만들고 첫 실행 주기를 시작하세요.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onCreateGoal,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
          ),
          icon: const Icon(Icons.add_rounded),
          label: const Text('목표 만들기'),
        ),
      ],
    );
  }
}

class _FocusMetric extends StatelessWidget {
  const _FocusMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.62),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}

class _FocusDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white.withValues(alpha: 0.18),
    );
  }
}
