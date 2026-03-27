import '../models/badge_history.dart';
import '../models/goal.dart';
import '../models/retrospective.dart';
import '../models/user_stats.dart';
import 'mock_seed_data.dart';

class MockStore {
  MockStore._({
    required this.goals,
    required this.retrospectives,
    required this.userStats,
    required this.badgeHistory,
  });

  factory MockStore.seeded() {
    return MockStore._(
      goals: seedGoals(),
      retrospectives: seedRetrospectives(),
      userStats: seedUserStats(),
      badgeHistory: seedBadgeHistory(),
    );
  }

  List<Goal> goals;
  List<Retrospective> retrospectives;
  UserStats userStats;
  List<BadgeHistory> badgeHistory;
}
