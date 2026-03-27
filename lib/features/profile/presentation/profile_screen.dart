import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../features/gamification/presentation/widgets/badge_card.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/metric_tile.dart';
import '../../../shared/widgets/section_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final userStats = appState.userStats;
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        const SectionHeader(
          title: '프로필 & 통계',
          subtitle: 'XP, 레벨, streak, 배지로 누적 실행량을 확인합니다.',
        ),
        const SizedBox(height: 16),
        AppCard(
          color: colorScheme.secondaryContainer.withValues(alpha: 0.75),
          child: Text(
            '현재 화면은 mock 데이터 기반 초안입니다. 계정 연동 없이도 게이미피케이션 구조와 확장 포인트가 보이도록 구성했습니다.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          children: [
            MetricTile(
              icon: Icons.auto_awesome_rounded,
              label: '총 XP',
              value: '${userStats.xp}',
              caption: 'Task 완료와 회고 작성으로 누적',
            ),
            MetricTile(
              icon: Icons.trending_up_rounded,
              label: '레벨',
              value: 'Lv.${userStats.level}',
              caption: 'XP 120 단위로 레벨업',
            ),
            MetricTile(
              icon: Icons.local_fire_department_rounded,
              label: '연속 실행',
              value: '${userStats.streakDays}일',
              caption: '최근 활동 기반 streak',
            ),
            MetricTile(
              icon: Icons.task_alt_rounded,
              label: '완료 태스크',
              value: '${userStats.completedTaskCount}개',
              caption: 'mock + in-memory 상태 포함',
            ),
          ],
        ),
        const SizedBox(height: 28),
        const SectionHeader(
          title: '획득 배지',
          subtitle: '목표 설정, 태스크 완료, 회고 작성 등 주요 이벤트에 반응합니다.',
        ),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: appState.recentBadges.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.88,
          ),
          itemBuilder: (context, index) {
            return BadgeCard(badge: appState.recentBadges[index]);
          },
        ),
        const SizedBox(height: 28),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재 구현 메모',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                '향후 Firebase Auth / Firestore 연동 시에는 현재 repository interface를 유지한 채 data source만 교체하는 방향을 전제로 두고 있습니다.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
