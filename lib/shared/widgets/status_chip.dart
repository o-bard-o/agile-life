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
          background: colorScheme.primary,
          foreground: colorScheme.onPrimary,
        ),
      StatusTone.success => (
          background: const Color(0xFFEDEDE8),
          foreground: const Color(0xFF111111),
        ),
      StatusTone.warning => (
          background: const Color(0xFFF6F6F1),
          foreground: const Color(0xFF3E403B),
        ),
      StatusTone.neutral => (
          background: colorScheme.surfaceContainerHighest,
          foreground: colorScheme.onSurfaceVariant,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
