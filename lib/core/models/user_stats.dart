class UserStats {
  const UserStats({
    required this.xp,
    required this.level,
    required this.streakDays,
    required this.completedTaskCount,
    required this.createdGoalCount,
    required this.completedSprintCount,
    required this.retrospectiveCount,
    this.lastActiveAt,
  });

  final int xp;
  final int level;
  final int streakDays;
  final int completedTaskCount;
  final int createdGoalCount;
  final int completedSprintCount;
  final int retrospectiveCount;
  final DateTime? lastActiveAt;

  UserStats copyWith({
    int? xp,
    int? level,
    int? streakDays,
    int? completedTaskCount,
    int? createdGoalCount,
    int? completedSprintCount,
    int? retrospectiveCount,
    DateTime? lastActiveAt,
    bool clearLastActiveAt = false,
  }) {
    return UserStats(
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      completedTaskCount: completedTaskCount ?? this.completedTaskCount,
      createdGoalCount: createdGoalCount ?? this.createdGoalCount,
      completedSprintCount: completedSprintCount ?? this.completedSprintCount,
      retrospectiveCount: retrospectiveCount ?? this.retrospectiveCount,
      lastActiveAt:
          clearLastActiveAt ? null : lastActiveAt ?? this.lastActiveAt,
    );
  }
}
