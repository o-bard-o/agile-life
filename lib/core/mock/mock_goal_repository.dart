import '../models/goal.dart';
import '../models/goal_draft.dart';
import '../models/milestone.dart';
import '../models/sprint.dart';
import '../models/task.dart';
import '../repositories/goal_repository.dart';
import '../../shared/utils/id_generator.dart';
import 'mock_store.dart';

class MockGoalRepository implements GoalRepository {
  MockGoalRepository(this._store);

  final MockStore _store;

  @override
  Goal createGoal(GoalDraft draft) {
    final now = DateTime.now();
    final goalId = IdGenerator.next('goal');
    final sprintId = IdGenerator.next('sprint');

    final goal = Goal(
      id: goalId,
      title: draft.title,
      description: draft.description,
      category: draft.category,
      status: GoalStatus.focus,
      createdAt: now,
      targetDate: draft.targetDate,
      milestones: [
        Milestone(
          id: IdGenerator.next('milestone'),
          title: '현재 상태 점검',
          note: '출발 지점과 측정 지표를 정리합니다.',
          dueDate: now.add(const Duration(days: 7)),
          isCompleted: false,
        ),
        Milestone(
          id: IdGenerator.next('milestone'),
          title: '첫 실행 사이클 완료',
          note: '첫 스프린트를 마치고 회고를 남깁니다.',
          dueDate: now.add(const Duration(days: 21)),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: sprintId,
          goalId: goalId,
          title: '첫 실행 스프린트',
          objective: '${draft.title} 목표를 작은 실행 단위로 쪼개서 첫 루틴을 만든다.',
          startDate: now,
          endDate: now.add(const Duration(days: 13)),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: false,
          tasks: _starterTasks(draft),
        ),
      ],
    );

    _store.goals = [goal, ..._store.goals];
    return goal;
  }

  @override
  Goal? fetchGoalById(String goalId) {
    for (final goal in _store.goals) {
      if (goal.id == goalId) {
        return goal;
      }
    }
    return null;
  }

  @override
  List<Goal> fetchGoals() => List<Goal>.from(_store.goals);

  List<Task> _starterTasks(GoalDraft draft) {
    final today = DateTime.now();
    final baseTasks = switch (draft.category) {
      '학습' => [
          '현재 실력 진단하기',
          '1주차 학습 계획 세우기',
          '복습 루틴 1회 실행하기',
        ],
      '건강' => [
          '이번 주 운동 일정 고정하기',
          '식단 기록 포맷 정하기',
          '가벼운 실행 루틴 1회 시작하기',
        ],
      '습관' => [
          '트리거 시간 정하기',
          '실행 기록 방법 정하기',
          '첫 주 루틴 3회분 예약하기',
        ],
      _ => [
          '목표 정의 다시 다듬기',
          '첫 스프린트 범위 정하기',
          '실행 블록 1개 예약하기',
        ],
    };

    return List<Task>.generate(baseTasks.length, (index) {
      return Task(
        id: IdGenerator.next('task'),
        title: baseTasks[index],
        note: '${draft.title} 목표용 초기 액션 아이템',
        dueDate: today.add(Duration(days: index)),
        isCompleted: false,
        xpReward: 15,
      );
    });
  }
}
