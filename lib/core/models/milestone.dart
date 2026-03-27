class Milestone {
  const Milestone({
    required this.id,
    required this.title,
    required this.note,
    required this.dueDate,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String note;
  final DateTime dueDate;
  final bool isCompleted;

  Milestone copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Milestone(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
