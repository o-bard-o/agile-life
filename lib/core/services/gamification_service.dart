import 'dart:math';

import '../models/badge_history.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../models/user_stats.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/utils/id_generator.dart';

class GamificationService {
  const GamificationService();

  static const int sprintCompletionBonusXp = 35;
  static const int retrospectiveBonusXp = 30;

  UserStats applyGoalCreated(UserStats stats) {
    final touched = _touch(stats);
    return _withLevel(
      touched.copyWith(
        createdGoalCount: touched.createdGoalCount + 1,
      ),
    );
  }

  UserStats applyRetrospectiveSaved(
    UserStats stats, {
    required bool wasCreated,
  }) {
    final touched = _touch(stats);

    if (!wasCreated) {
      return _withLevel(touched);
    }

    return _withLevel(
      touched.copyWith(
        xp: touched.xp + retrospectiveBonusXp,
        retrospectiveCount: touched.retrospectiveCount + 1,
      ),
    );
  }

  UserStats applyTaskToggle(
    UserStats stats, {
    required Task task,
    required bool isNowCompleted,
    required bool earnedCompletionBonus,
    required bool didCompleteSprint,
  }) {
    final touched = _touch(stats);

    var xpDelta = isNowCompleted ? task.xpReward : -task.xpReward;
    if (isNowCompleted && earnedCompletionBonus) {
      xpDelta += sprintCompletionBonusXp;
    }

    return _withLevel(
      touched.copyWith(
        xp: max(0, touched.xp + xpDelta),
        completedTaskCount: max(
          0,
          touched.completedTaskCount + (isNowCompleted ? 1 : -1),
        ),
        completedSprintCount: touched.completedSprintCount +
            (didCompleteSprint && isNowCompleted ? 1 : 0),
      ),
    );
  }

  List<BadgeHistory> evaluateBadges({
    required List<BadgeHistory> currentBadges,
    required UserStats stats,
    required List<Goal> goals,
  }) {
    final badges = List<BadgeHistory>.from(currentBadges);
    final existingKeys = badges.map((badge) => badge.badgeKey).toSet();

    void addBadge({
      required String key,
      required String title,
      required String description,
      required String iconKey,
      required bool condition,
    }) {
      if (!condition || existingKeys.contains(key)) {
        return;
      }

      badges.insert(
        0,
        BadgeHistory(
          id: IdGenerator.next('badge'),
          badgeKey: key,
          title: title,
          description: description,
          iconKey: iconKey,
          achievedAt: DateTime.now(),
        ),
      );
      existingKeys.add(key);
    }

    addBadge(
      key: 'first_goal',
      title: '첫 목표 설정',
      description: '장기 목표를 실행 단위로 나누기 시작했습니다.',
      iconKey: 'flag',
      condition: stats.createdGoalCount >= 1 || goals.isNotEmpty,
    );
    addBadge(
      key: 'first_sprint',
      title: '첫 스프린트 완주',
      description: '첫 스프린트를 끝까지 완료했습니다.',
      iconKey: 'sprint',
      condition: stats.completedSprintCount >= 1,
    );
    addBadge(
      key: 'seven_tasks',
      title: '7개 태스크 완료',
      description: '누적 7개의 Task를 체크했습니다.',
      iconKey: 'tasks',
      condition: stats.completedTaskCount >= 7,
    );
    addBadge(
      key: 'first_retro',
      title: '첫 회고 작성',
      description: '첫 회고를 작성해 다음 계획을 다듬었습니다.',
      iconKey: 'insights',
      condition: stats.retrospectiveCount >= 1,
    );

    return badges;
  }

  UserStats _touch(UserStats stats) {
    final now = DateTime.now();
    final lastActiveAt = stats.lastActiveAt;

    if (lastActiveAt == null) {
      return stats.copyWith(
        streakDays: max(1, stats.streakDays),
        lastActiveAt: now,
      );
    }

    final difference = differenceInCalendarDays(now, lastActiveAt);
    final streakDays = switch (difference) {
      0 => stats.streakDays,
      1 => stats.streakDays + 1,
      _ => 1,
    };

    return stats.copyWith(
      streakDays: streakDays,
      lastActiveAt: now,
    );
  }

  UserStats _withLevel(UserStats stats) {
    return stats.copyWith(level: levelForXp(stats.xp));
  }

  int levelForXp(int xp) => (xp ~/ 120) + 1;
}
