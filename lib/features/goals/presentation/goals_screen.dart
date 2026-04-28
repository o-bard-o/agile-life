import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/status_presenter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_chip.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        SectionHeader(
          title: '목표',
          subtitle: '진행 중인 장기 목표입니다.',
          actionLabel: '새 목표',
          onAction: () => context.pushNamed(AppRoutes.goalCreateName),
        ),
        const SizedBox(height: 16),
        ...appState.goals.map(
          (goal) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              goal.category,
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
                      StatusChip(
                        label: goalStatusLabel(goal.status),
                        tone: goalStatusTone(goal.status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    goal.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
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
                    '진행률 ${(goal.progress * 100).round()}% · 마일스톤 ${goal.milestones.length}개 · 스프린트 ${goal.sprints.length}개',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppDateFormatter.fullDate(goal.targetDate),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (goal.currentSprint != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      goal.currentSprint!.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
