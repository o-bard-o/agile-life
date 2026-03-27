import '../../core/models/badge_history.dart';
import '../../core/models/goal.dart';
import '../../core/models/retrospective.dart';
import '../../core/models/sprint.dart';
import '../../core/models/task.dart';
import '../../core/models/user_stats.dart';
import '../utils/date_utils.dart';

class TodayTaskEntry {
  const TodayTaskEntry({
    required this.goal,
    required this.sprint,
    required this.task,
  });

  final Goal goal;
  final Sprint sprint;
  final Task task;
}

class SprintEntry {
  const SprintEntry({
    required this.goal,
    required this.sprint,
  });

  final Goal goal;
  final Sprint sprint;
}

class AppState {
  const AppState({
    required this.hasCompletedOnboarding,
    required this.goals,
    required this.retrospectives,
    required this.userStats,
    required this.badgeHistory,
  });

  final bool hasCompletedOnboarding;
  final List<Goal> goals;
  final List<Retrospective> retrospectives;
  final UserStats userStats;
  final List<BadgeHistory> badgeHistory;

  Goal? goalById(String goalId) {
    for (final goal in goals) {
      if (goal.id == goalId) {
        return goal;
      }
    }
    return null;
  }

  Goal? goalForSprint(String sprintId) {
    for (final goal in goals) {
      for (final sprint in goal.sprints) {
        if (sprint.id == sprintId) {
          return goal;
        }
      }
    }
    return null;
  }

  Sprint? sprintById(String sprintId) {
    for (final goal in goals) {
      for (final sprint in goal.sprints) {
        if (sprint.id == sprintId) {
          return sprint;
        }
      }
    }
    return null;
  }

  Retrospective? retrospectiveBySprintId(String sprintId) {
    for (final retrospective in retrospectives) {
      if (retrospective.sprintId == sprintId) {
        return retrospective;
      }
    }
    return null;
  }

  SprintEntry? get currentSprintEntry {
    final entries = sprintEntries
        .where((entry) => entry.sprint.status == SprintStatus.active)
        .toList()
      ..sort(
        (left, right) => left.sprint.endDate.compareTo(right.sprint.endDate),
      );

    return entries.isNotEmpty ? entries.first : null;
  }

  List<SprintEntry> get sprintEntries {
    final entries = <SprintEntry>[];
    for (final goal in goals) {
      for (final sprint in goal.sprints) {
        entries.add(SprintEntry(goal: goal, sprint: sprint));
      }
    }

    entries.sort((left, right) {
      if (left.sprint.status != right.sprint.status) {
        return left.sprint.status.index.compareTo(right.sprint.status.index);
      }
      return left.sprint.endDate.compareTo(right.sprint.endDate);
    });
    return entries;
  }

  List<TodayTaskEntry> get todayTasks {
    final today = DateTime.now();
    final entries = <TodayTaskEntry>[];

    for (final goal in goals) {
      for (final sprint in goal.sprints) {
        if (sprint.status == SprintStatus.planned) {
          continue;
        }

        for (final task in sprint.tasks) {
          if (isSameDate(task.dueDate, today)) {
            entries.add(
              TodayTaskEntry(
                goal: goal,
                sprint: sprint,
                task: task,
              ),
            );
          }
        }
      }
    }

    entries
        .sort((left, right) => left.task.dueDate.compareTo(right.task.dueDate));
    return entries;
  }

  List<BadgeHistory> get recentBadges {
    return List<BadgeHistory>.from(badgeHistory)
      ..sort((left, right) => right.achievedAt.compareTo(left.achievedAt));
  }

  AppState copyWith({
    bool? hasCompletedOnboarding,
    List<Goal>? goals,
    List<Retrospective>? retrospectives,
    UserStats? userStats,
    List<BadgeHistory>? badgeHistory,
  }) {
    return AppState(
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      goals: goals ?? this.goals,
      retrospectives: retrospectives ?? this.retrospectives,
      userStats: userStats ?? this.userStats,
      badgeHistory: badgeHistory ?? this.badgeHistory,
    );
  }
}
