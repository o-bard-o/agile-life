import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../features/gamification/presentation/widgets/badge_card.dart';
import '../../../shared/widgets/metric_tile.dart';
import '../../../shared/widgets/section_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateControllerProvider);
    final userStats = appState.userStats;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        const SectionHeader(
          title: '프로필',
          subtitle: '누적 실행 기록입니다.',
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.78,
          children: [
            MetricTile(
              icon: Icons.auto_awesome_rounded,
              label: '총 XP',
              value: '${userStats.xp}',
              caption: '완료한 실행의 합',
            ),
            MetricTile(
              icon: Icons.trending_up_rounded,
              label: '레벨',
              value: 'Lv.${userStats.level}',
              caption: '현재 성장 단계',
            ),
            MetricTile(
              icon: Icons.local_fire_department_rounded,
              label: '연속 실행',
              value: '${userStats.streakDays}일',
              caption: '끊기지 않은 흐름',
            ),
            MetricTile(
              icon: Icons.task_alt_rounded,
              label: '완료 태스크',
              value: '${userStats.completedTaskCount}개',
              caption: '누적 체크리스트',
            ),
          ],
        ),
        const SizedBox(height: 28),
        const SectionHeader(
          title: '획득 배지',
          subtitle: '중요한 실행 순간을 남겼습니다.',
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
      ],
    );
  }
}
