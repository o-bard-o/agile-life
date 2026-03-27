import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/state/app_state.dart';
import '../../shared/state/app_state_controller.dart';
import '../mock/mock_goal_repository.dart';
import '../mock/mock_retrospective_repository.dart';
import '../mock/mock_sprint_repository.dart';
import '../mock/mock_stats_repository.dart';
import '../mock/mock_store.dart';
import '../repositories/goal_repository.dart';
import '../repositories/retrospective_repository.dart';
import '../repositories/sprint_repository.dart';
import '../repositories/stats_repository.dart';
import '../services/gamification_service.dart';

final mockStoreProvider = Provider<MockStore>((ref) {
  // TODO(firebase): Replace the seeded in-memory store with remote sources.
  return MockStore.seeded();
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return MockGoalRepository(ref.read(mockStoreProvider));
});

final sprintRepositoryProvider = Provider<SprintRepository>((ref) {
  return MockSprintRepository(ref.read(mockStoreProvider));
});

final retrospectiveRepositoryProvider =
    Provider<RetrospectiveRepository>((ref) {
  return MockRetrospectiveRepository(ref.read(mockStoreProvider));
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return MockStatsRepository(ref.read(mockStoreProvider));
});

final gamificationServiceProvider = Provider<GamificationService>((ref) {
  return const GamificationService();
});

final appStateControllerProvider =
    NotifierProvider<AppStateController, AppState>(AppStateController.new);
