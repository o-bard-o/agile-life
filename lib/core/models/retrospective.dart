class Retrospective {
  const Retrospective({
    required this.id,
    required this.goalId,
    required this.sprintId,
    required this.wentWell,
    required this.challenges,
    required this.keepDoing,
    required this.changeNext,
    required this.createdAt,
  });

  final String id;
  final String goalId;
  final String sprintId;
  final String wentWell;
  final String challenges;
  final String keepDoing;
  final String changeNext;
  final DateTime createdAt;

  Retrospective copyWith({
    String? id,
    String? goalId,
    String? sprintId,
    String? wentWell,
    String? challenges,
    String? keepDoing,
    String? changeNext,
    DateTime? createdAt,
  }) {
    return Retrospective(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      sprintId: sprintId ?? this.sprintId,
      wentWell: wentWell ?? this.wentWell,
      challenges: challenges ?? this.challenges,
      keepDoing: keepDoing ?? this.keepDoing,
      changeNext: changeNext ?? this.changeNext,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
