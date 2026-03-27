import '../models/badge_history.dart';
import '../models/user_stats.dart';
import '../repositories/stats_repository.dart';
import 'mock_store.dart';

class MockStatsRepository implements StatsRepository {
  MockStatsRepository(this._store);

  final MockStore _store;

  @override
  List<BadgeHistory> fetchBadges() =>
      List<BadgeHistory>.from(_store.badgeHistory)
        ..sort((left, right) => right.achievedAt.compareTo(left.achievedAt));

  @override
  UserStats fetchUserStats() => _store.userStats;

  @override
  void saveBadges(List<BadgeHistory> badges) {
    _store.badgeHistory = badges;
  }

  @override
  void saveUserStats(UserStats stats) {
    _store.userStats = stats;
  }
}
