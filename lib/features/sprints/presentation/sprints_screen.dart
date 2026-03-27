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

class SprintsScreen extends ConsumerWidget {
  const SprintsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        SectionHeader(
          title: '스프린트 보드',
          subtitle: 'Goal 아래에서 실행 단위를 1~2주 스프린트로 관리합니다.',
        ),
        const SizedBox(height: 16),
        AppCard(
          color: colorScheme.primaryContainer.withValues(alpha: 0.7),
          child: Text(
            '완료율 80% 이상 스프린트는 추가 XP를 획득합니다. 회고를 남기면 다음 스프린트 개선 흐름도 이어집니다.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
          ),
        ),
        const SizedBox(height: 16),
        ...appState.sprintEntries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.sprint.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.goal.title,
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
                        label: sprintStatusLabel(entry.sprint.status),
                        tone: sprintStatusTone(entry.sprint.status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(entry.sprint.objective),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: entry.sprint.progress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${entry.sprint.completedTaskCount}/${entry.sprint.totalTaskCount}개 완료 · ${AppDateFormatter.range(entry.sprint.startDate, entry.sprint.endDate)}',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (entry.sprint.retrospectiveCompleted)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusChip(
                            label: '회고 작성됨',
                            tone: StatusTone.success,
                          ),
                        ),
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: () {
                            context.pushNamed(
                              AppRoutes.sprintDetailName,
                              pathParameters: {'sprintId': entry.sprint.id},
                            );
                          },
                          child: const Text('상세 보기'),
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
    );
  }
}
