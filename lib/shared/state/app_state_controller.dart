import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/goal_draft.dart';
import '../../core/models/retrospective_draft.dart';
import '../../core/models/user_stats.dart';
import '../../core/providers/app_providers.dart';
import '../../core/repositories/goal_repository.dart';
import '../../core/repositories/retrospective_repository.dart';
import '../../core/repositories/sprint_repository.dart';
import '../../core/repositories/stats_repository.dart';
import '../../core/services/gamification_service.dart';
import 'app_state.dart';

class AppStateController extends Notifier<AppState> {
  late final GoalRepository _goalRepository;
  late final SprintRepository _sprintRepository;
  late final RetrospectiveRepository _retrospectiveRepository;
  late final StatsRepository _statsRepository;
  late final GamificationService _gamificationService;

  bool _hasCompletedOnboarding = false;

  @override
  AppState build() {
    _goalRepository = ref.read(goalRepositoryProvider);
    _sprintRepository = ref.read(sprintRepositoryProvider);
    _retrospectiveRepository = ref.read(retrospectiveRepositoryProvider);
    _statsRepository = ref.read(statsRepositoryProvider);
    _gamificationService = ref.read(gamificationServiceProvider);

    return _snapshot();
  }

  void completeOnboarding() {
    _hasCompletedOnboarding = true;
    state = _snapshot();
  }

  void addGoal(GoalDraft draft) {
    _goalRepository.createGoal(draft);
    final updatedStats = _gamificationService.applyGoalCreated(
      _statsRepository.fetchUserStats(),
    );
    _statsRepository.saveUserStats(updatedStats);
    _updateBadges(updatedStats);
    state = _snapshot();
  }

  void toggleTask({
    required String sprintId,
    required String taskId,
  }) {
    final result = _sprintRepository.toggleTask(
      sprintId: sprintId,
      taskId: taskId,
    );
    final updatedStats = _gamificationService.applyTaskToggle(
      _statsRepository.fetchUserStats(),
      task: result.task,
      isNowCompleted: result.isNowCompleted,
      earnedCompletionBonus: result.earnedCompletionBonus,
      didCompleteSprint: result.didCompleteSprint,
    );
    _statsRepository.saveUserStats(updatedStats);
    _updateBadges(updatedStats);
    state = _snapshot();
  }

  bool submitRetrospective(RetrospectiveDraft draft) {
    final result = _retrospectiveRepository.saveRetrospective(draft);
    final updatedStats = _gamificationService.applyRetrospectiveSaved(
      _statsRepository.fetchUserStats(),
      wasCreated: result.wasCreated,
    );
    _statsRepository.saveUserStats(updatedStats);
    _updateBadges(updatedStats);
    state = _snapshot();
    return result.wasCreated;
  }

  AppState _snapshot() {
    return AppState(
      hasCompletedOnboarding: _hasCompletedOnboarding,
      goals: _goalRepository.fetchGoals(),
      retrospectives: _retrospectiveRepository.fetchRetrospectives(),
      userStats: _statsRepository.fetchUserStats(),
      badgeHistory: _statsRepository.fetchBadges(),
    );
  }

  void _updateBadges(UserStats updatedStats) {
    final badges = _gamificationService.evaluateBadges(
      currentBadges: _statsRepository.fetchBadges(),
      stats: updatedStats,
      goals: _goalRepository.fetchGoals(),
    );
    _statsRepository.saveBadges(badges);
  }
}
