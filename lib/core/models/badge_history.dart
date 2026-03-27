class BadgeHistory {
  const BadgeHistory({
    required this.id,
    required this.badgeKey,
    required this.title,
    required this.description,
    required this.iconKey,
    required this.achievedAt,
  });

  final String id;
  final String badgeKey;
  final String title;
  final String description;
  final String iconKey;
  final DateTime achievedAt;

  BadgeHistory copyWith({
    String? id,
    String? badgeKey,
    String? title,
    String? description,
    String? iconKey,
    DateTime? achievedAt,
  }) {
    return BadgeHistory(
      id: id ?? this.id,
      badgeKey: badgeKey ?? this.badgeKey,
      title: title ?? this.title,
      description: description ?? this.description,
      iconKey: iconKey ?? this.iconKey,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }
}
