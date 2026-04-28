import 'package:flutter/material.dart';

import '../../../../core/models/badge_history.dart';
import '../../../../shared/utils/date_formatter.dart';
import '../../../../shared/utils/status_presenter.dart';
import '../../../../shared/widgets/app_card.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.badge,
  });

  final BadgeHistory badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            badgeIconFor(badge.iconKey),
            size: 24,
            color: colorScheme.onSurface,
          ),
          const SizedBox(height: 16),
          Text(
            badge.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            badge.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            AppDateFormatter.fullDate(badge.achievedAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
