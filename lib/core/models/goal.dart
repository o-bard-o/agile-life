import 'milestone.dart';
import 'sprint.dart';

enum GoalStatus { focus, steady, atRisk, completed }

class Goal {
  const Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.targetDate,
    required this.milestones,
    required this.sprints,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final GoalStatus status;
  final DateTime createdAt;
  final DateTime targetDate;
  final List<Milestone> milestones;
  final List<Sprint> sprints;

  Sprint? get currentSprint {
    for (final sprint in sprints) {
      if (sprint.status == SprintStatus.active) {
        return sprint;
      }
    }
    return sprints.isNotEmpty ? sprints.first : null;
  }

  double get progress {
    final tasks = sprints.expand((sprint) => sprint.tasks).toList();
    if (tasks.isNotEmpty) {
      final completedTasks = tasks.where((task) => task.isCompleted).length;
      return completedTasks / tasks.length;
    }

    if (milestones.isEmpty) {
      return 0;
    }

    final completedMilestones =
        milestones.where((milestone) => milestone.isCompleted).length;
    return completedMilestones / milestones.length;
  }

  Goal copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    GoalStatus? status,
    DateTime? createdAt,
    DateTime? targetDate,
    List<Milestone>? milestones,
    List<Sprint>? sprints,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      targetDate: targetDate ?? this.targetDate,
      milestones: milestones ?? this.milestones,
      sprints: sprints ?? this.sprints,
    );
  }
}
