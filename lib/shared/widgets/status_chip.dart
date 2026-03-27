import 'package:flutter/material.dart';

enum StatusTone { neutral, info, success, warning }

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.tone,
  });

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final ({Color background, Color foreground}) colors = switch (tone) {
      StatusTone.info => (
          background: colorScheme.primaryContainer,
          foreground: colorScheme.onPrimaryContainer,
        ),
      StatusTone.success => (
          background: const Color(0xFFD7F3E9),
          foreground: const Color(0xFF136B43),
        ),
      StatusTone.warning => (
          background: const Color(0xFFFFE7C5),
          foreground: const Color(0xFF9A5A00),
        ),
      StatusTone.neutral => (
          background: colorScheme.surfaceContainerHighest,
          foreground: colorScheme.onSurfaceVariant,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
