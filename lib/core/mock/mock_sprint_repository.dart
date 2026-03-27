import '../models/sprint.dart';
import '../models/task.dart';
import '../repositories/sprint_repository.dart';
import 'mock_store.dart';

class MockSprintRepository implements SprintRepository {
  MockSprintRepository(this._store);

  final MockStore _store;

  @override
  List<Sprint> fetchAllSprints() {
    return _store.goals.expand((goal) => goal.sprints).toList();
  }

  @override
  Sprint? fetchCurrentSprint() {
    final activeSprints = fetchAllSprints()
        .where((sprint) => sprint.status == SprintStatus.active)
        .toList()
      ..sort((left, right) => left.endDate.compareTo(right.endDate));

    return activeSprints.isNotEmpty ? activeSprints.first : null;
  }

  @override
  Sprint? fetchSprintById(String sprintId) {
    for (final goal in _store.goals) {
      for (final sprint in goal.sprints) {
        if (sprint.id == sprintId) {
          return sprint;
        }
      }
    }
    return null;
  }

  @override
  TaskToggleResult toggleTask({
    required String sprintId,
    required String taskId,
  }) {
    for (var goalIndex = 0; goalIndex < _store.goals.length; goalIndex++) {
      final goal = _store.goals[goalIndex];

      for (var sprintIndex = 0;
          sprintIndex < goal.sprints.length;
          sprintIndex++) {
        final sprint = goal.sprints[sprintIndex];
        if (sprint.id != sprintId) {
          continue;
        }

        final tasks = List<Task>.from(sprint.tasks);
        final taskIndex = tasks.indexWhere((task) => task.id == taskId);
        if (taskIndex == -1) {
          throw StateError('Task not found: $taskId');
        }

        final originalTask = tasks[taskIndex];
        final toggledTask = originalTask.copyWith(
          isCompleted: !originalTask.isCompleted,
          completedAt: originalTask.isCompleted ? null : DateTime.now(),
          clearCompletedAt: originalTask.isCompleted,
        );

        tasks[taskIndex] = toggledTask;
        var updatedSprint = sprint.copyWith(tasks: tasks);

        final earnedCompletionBonus =
            !sprint.completionBonusAwarded && updatedSprint.progress >= 0.8;
        final didCompleteSprint =
            !sprint.isCompleted && updatedSprint.isCompleted;

        updatedSprint = updatedSprint.copyWith(
          status: updatedSprint.isCompleted
              ? SprintStatus.completed
              : SprintStatus.active,
          completionBonusAwarded:
              sprint.completionBonusAwarded || earnedCompletionBonus,
        );

        final updatedSprints = List<Sprint>.from(goal.sprints);
        updatedSprints[sprintIndex] = updatedSprint;
        final updatedGoal = goal.copyWith(sprints: updatedSprints);
        _store.goals[goalIndex] = updatedGoal;

        return TaskToggleResult(
          goal: updatedGoal,
          sprint: updatedSprint,
          task: toggledTask,
          isNowCompleted: toggledTask.isCompleted,
          earnedCompletionBonus: earnedCompletionBonus,
          didCompleteSprint: didCompleteSprint,
        );
      }
    }

    throw StateError('Sprint not found: $sprintId');
  }
}
