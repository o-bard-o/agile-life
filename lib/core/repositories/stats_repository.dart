import '../models/badge_history.dart';
import '../models/user_stats.dart';

abstract class StatsRepository {
  List<BadgeHistory> fetchBadges();

  UserStats fetchUserStats();

  void saveBadges(List<BadgeHistory> badges);

  void saveUserStats(UserStats stats);
}
