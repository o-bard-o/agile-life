class Task {
  const Task({
    required this.id,
    required this.title,
    required this.note,
    required this.dueDate,
    required this.isCompleted,
    required this.xpReward,
    this.completedAt,
  });

  final String id;
  final String title;
  final String note;
  final DateTime dueDate;
  final bool isCompleted;
  final int xpReward;
  final DateTime? completedAt;

  Task copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? dueDate,
    bool? isCompleted,
    int? xpReward,
    DateTime? completedAt,
    bool clearCompletedAt = false,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      xpReward: xpReward ?? this.xpReward,
      completedAt: clearCompletedAt ? null : completedAt ?? this.completedAt,
    );
  }
}
