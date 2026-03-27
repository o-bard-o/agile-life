import '../models/goal.dart';
import '../models/goal_draft.dart';

abstract class GoalRepository {
  // TODO(firebase): Swap this interface to a Firestore-backed repository.
  List<Goal> fetchGoals();

  Goal? fetchGoalById(String goalId);

  Goal createGoal(GoalDraft draft);
}
