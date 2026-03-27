import '../models/goal.dart';
import '../models/sprint.dart';
import '../models/task.dart';

class TaskToggleResult {
  const TaskToggleResult({
    required this.goal,
    required this.sprint,
    required this.task,
    required this.isNowCompleted,
    required this.earnedCompletionBonus,
    required this.didCompleteSprint,
  });

  final Goal goal;
  final Sprint sprint;
  final Task task;
  final bool isNowCompleted;
  final bool earnedCompletionBonus;
  final bool didCompleteSprint;
}

abstract class SprintRepository {
  // TODO(firebase): Move sprint mutation logic to a remote data source later.
  List<Sprint> fetchAllSprints();

  Sprint? fetchCurrentSprint();

  Sprint? fetchSprintById(String sprintId);

  TaskToggleResult toggleTask({
    required String sprintId,
    required String taskId,
  });
}
