import 'task.dart';

enum SprintStatus { planned, active, completed }

class Sprint {
  const Sprint({
    required this.id,
    required this.goalId,
    required this.title,
    required this.objective,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.tasks,
    required this.completionBonusAwarded,
    required this.retrospectiveCompleted,
  });

  final String id;
  final String goalId;
  final String title;
  final String objective;
  final DateTime startDate;
  final DateTime endDate;
  final SprintStatus status;
  final List<Task> tasks;
  final bool completionBonusAwarded;
  final bool retrospectiveCompleted;

  int get totalTaskCount => tasks.length;

  int get completedTaskCount => tasks.where((task) => task.isCompleted).length;

  double get progress {
    if (tasks.isEmpty) {
      return 0;
    }
    return completedTaskCount / totalTaskCount;
  }

  bool get isCompleted => progress >= 1;

  Sprint copyWith({
    String? id,
    String? goalId,
    String? title,
    String? objective,
    DateTime? startDate,
    DateTime? endDate,
    SprintStatus? status,
    List<Task>? tasks,
    bool? completionBonusAwarded,
    bool? retrospectiveCompleted,
  }) {
    return Sprint(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      objective: objective ?? this.objective,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      completionBonusAwarded:
          completionBonusAwarded ?? this.completionBonusAwarded,
      retrospectiveCompleted:
          retrospectiveCompleted ?? this.retrospectiveCompleted,
    );
  }
}
