import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (checked) => onChanged(checked ?? false),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                decoration: value ? TextDecoration.lineThrough : null,
              ),
        ),
        subtitle: Text(subtitle),
        secondary: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            trailing,
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
