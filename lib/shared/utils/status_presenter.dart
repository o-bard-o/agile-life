import 'package:flutter/material.dart';

import '../../core/models/goal.dart';
import '../../core/models/sprint.dart';
import '../widgets/status_chip.dart';

String goalStatusLabel(GoalStatus status) {
  return switch (status) {
    GoalStatus.focus => '집중',
    GoalStatus.steady => '진행 중',
    GoalStatus.atRisk => '주의',
    GoalStatus.completed => '완료',
  };
}

StatusTone goalStatusTone(GoalStatus status) {
  return switch (status) {
    GoalStatus.focus => StatusTone.info,
    GoalStatus.steady => StatusTone.success,
    GoalStatus.atRisk => StatusTone.warning,
    GoalStatus.completed => StatusTone.neutral,
  };
}

String sprintStatusLabel(SprintStatus status) {
  return switch (status) {
    SprintStatus.planned => '예정',
    SprintStatus.active => '진행 중',
    SprintStatus.completed => '완료',
  };
}

StatusTone sprintStatusTone(SprintStatus status) {
  return switch (status) {
    SprintStatus.planned => StatusTone.neutral,
    SprintStatus.active => StatusTone.info,
    SprintStatus.completed => StatusTone.success,
  };
}

IconData badgeIconFor(String iconKey) {
  return switch (iconKey) {
    'flag' => Icons.flag_rounded,
    'sprint' => Icons.rocket_launch_rounded,
    'tasks' => Icons.task_alt_rounded,
    'insights' => Icons.insights_rounded,
    _ => Icons.military_tech_rounded,
  };
}
