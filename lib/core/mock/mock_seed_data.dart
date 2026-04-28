import '../models/badge_history.dart';
import '../models/goal.dart';
import '../models/milestone.dart';
import '../models/retrospective.dart';
import '../models/sprint.dart';
import '../models/task.dart';
import '../models/user_stats.dart';

DateTime _today() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

DateTime _at(DateTime date, int hour, int minute) {
  return DateTime(date.year, date.month, date.day, hour, minute);
}

List<Goal> seedGoals() {
  final today = _today();

  return [
    Goal(
      id: 'goal_toeic_850',
      title: '토익 850점 달성',
      description: 'LC 약점을 줄이고 실전 시간 관리 루틴을 만들어 6월 시험에서 850점을 넘긴다.',
      category: '학습',
      status: GoalStatus.focus,
      createdAt: today.subtract(const Duration(days: 24)),
      targetDate: today.add(const Duration(days: 64)),
      milestones: [
        Milestone(
          id: 'mile_toeic_mock_780',
          title: '모의고사 780점 달성',
          note: 'LC/RC 현재 체력을 확인하는 기준 점수',
          dueDate: today.subtract(const Duration(days: 7)),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_toeic_lc_review',
          title: 'LC 오답 노트 3회독',
          note: '자주 틀리는 발음과 패턴 정리',
          dueDate: today.add(const Duration(days: 13)),
          isCompleted: false,
        ),
        Milestone(
          id: 'mile_toeic_real_850',
          title: '실전 시험 850점 도달',
          note: '시험장 루틴까지 점검',
          dueDate: today.add(const Duration(days: 64)),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_toeic_active',
          goalId: 'goal_toeic_850',
          title: 'LC 집중 스프린트',
          objective: '파트 2 오답률을 낮추고 파트 7 풀이 시간을 안정화한다.',
          startDate: today.subtract(const Duration(days: 3)),
          endDate: today.add(const Duration(days: 10)),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: false,
          tasks: [
            Task(
              id: 'task_toeic_shadowing',
              title: 'LC 파트 2 쉐도잉 20분',
              note: '잘 안 들리는 발음 10개 기록',
              dueDate: today,
              isCompleted: false,
              xpReward: 15,
            ),
            Task(
              id: 'task_toeic_mock',
              title: '모의고사 1회분 풀기',
              note: 'RC 파트 7 제한 시간 체크',
              dueDate: today,
              isCompleted: true,
              xpReward: 20,
              completedAt: _at(today, 9, 20),
            ),
            Task(
              id: 'task_toeic_review',
              title: '오답 노트 3개 문장 정리',
              note: '틀린 이유와 다시 풀 전략 작성',
              dueDate: today.add(const Duration(days: 1)),
              isCompleted: false,
              xpReward: 15,
            ),
            Task(
              id: 'task_toeic_part7',
              title: 'RC 파트 7 시간 측정 풀이',
              note: '지문당 8분 이내 목표',
              dueDate: today.add(const Duration(days: 2)),
              isCompleted: false,
              xpReward: 20,
            ),
          ],
        ),
      ],
    ),
    Goal(
      id: 'goal_weight_loss',
      title: '체중 5kg 감량',
      description: '지속 가능한 운동 빈도와 식단 기록으로 8주 동안 체지방을 낮춘다.',
      category: '건강',
      status: GoalStatus.steady,
      createdAt: today.subtract(const Duration(days: 18)),
      targetDate: today.add(const Duration(days: 52)),
      milestones: [
        Milestone(
          id: 'mile_weight_check',
          title: '주 4회 운동 루틴 고정',
          note: '헬스장 3회, 걷기 1회',
          dueDate: today.subtract(const Duration(days: 2)),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_weight_minus3',
          title: '3kg 감량',
          note: '체중과 허리둘레 함께 기록',
          dueDate: today.add(const Duration(days: 22)),
          isCompleted: false,
        ),
        Milestone(
          id: 'mile_weight_minus5',
          title: '최종 5kg 감량',
          note: '유지 가능한 루틴까지 정착',
          dueDate: today.add(const Duration(days: 52)),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_weight_routine',
          goalId: 'goal_weight_loss',
          title: '식단 기록 스프린트',
          objective: '저녁 식단을 안정화하고 주간 운동 빈도를 고정한다.',
          startDate: today.subtract(const Duration(days: 6)),
          endDate: today.add(const Duration(days: 7)),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: true,
          tasks: [
            Task(
              id: 'task_weight_walk',
              title: '저녁 식사 후 30분 걷기',
              note: '비 오는 날은 실내 자전거로 대체',
              dueDate: today,
              isCompleted: true,
              xpReward: 10,
              completedAt: _at(today, 20, 40),
            ),
            Task(
              id: 'task_weight_protein',
              title: '단백질 중심 저녁 식단 기록',
              note: '사진과 메모 한 줄 남기기',
              dueDate: today.add(const Duration(days: 1)),
              isCompleted: true,
              xpReward: 10,
              completedAt: _at(today.subtract(const Duration(days: 1)), 19, 10),
            ),
            Task(
              id: 'task_weight_gym',
              title: '하체 중심 웨이트 40분',
              note: '스쿼트, 런지, 레그프레스',
              dueDate: today.add(const Duration(days: 2)),
              isCompleted: false,
              xpReward: 20,
            ),
          ],
        ),
      ],
    ),
    Goal(
      id: 'goal_reading_daily',
      title: '매일 독서 20분',
      description: '짧더라도 매일 같은 시간에 읽고 핵심 문장을 기록한다.',
      category: '습관',
      status: GoalStatus.steady,
      createdAt: today.subtract(const Duration(days: 12)),
      targetDate: today.add(const Duration(days: 38)),
      milestones: [
        Milestone(
          id: 'mile_reading_week1',
          title: '7일 연속 독서',
          note: '시간보다 루틴 고정이 우선',
          dueDate: today.subtract(const Duration(days: 4)),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_reading_pages',
          title: '책 1권 완독',
          note: '핵심 문장 5개 메모',
          dueDate: today.add(const Duration(days: 19)),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_reading_focus',
          goalId: 'goal_reading_daily',
          title: '아침 독서 루틴',
          objective: '출근 전 20분 독서를 주 5회 이상 지킨다.',
          startDate: today.subtract(const Duration(days: 3)),
          endDate: today.add(const Duration(days: 10)),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: false,
          tasks: [
            Task(
              id: 'task_reading_today',
              title: '아침 독서 20분',
              note: '하이라이트 1개 남기기',
              dueDate: today,
              isCompleted: false,
              xpReward: 12,
            ),
            Task(
              id: 'task_reading_summary',
              title: '이번 주 문장 정리',
              note: '인상 깊은 문장 3개 기록',
              dueDate: today.add(const Duration(days: 3)),
              isCompleted: false,
              xpReward: 12,
            ),
          ],
        ),
      ],
    ),
  ];
}

List<Retrospective> seedRetrospectives() {
  final today = _today();

  return [
    Retrospective(
      id: 'retro_weight_week1',
      goalId: 'goal_weight_loss',
      sprintId: 'sprint_weight_routine',
      wentWell: '저녁 식단 기록이 안정적으로 유지됐다.',
      challenges: '퇴근이 늦은 날은 운동 강도를 지키기 어려웠다.',
      keepDoing: '식단 사진과 한 줄 메모를 계속 남긴다.',
      changeNext: '주말에 다음 주 운동 시간을 미리 확보한다.',
      createdAt: _at(today.subtract(const Duration(days: 2)), 21, 0),
    ),
  ];
}

UserStats seedUserStats() {
  final today = _today();

  return UserStats(
    xp: 182,
    level: 2,
    streakDays: 5,
    completedTaskCount: 6,
    createdGoalCount: 3,
    completedSprintCount: 0,
    retrospectiveCount: 1,
    lastActiveAt: _at(today, 8, 40),
  );
}

List<BadgeHistory> seedBadgeHistory() {
  final today = _today();

  return [
    BadgeHistory(
      id: 'badge_first_goal',
      badgeKey: 'first_goal',
      title: '첫 목표 설정',
      description: '장기 목표를 실행 단위로 나누기 시작했습니다.',
      iconKey: 'flag',
      achievedAt: _at(today.subtract(const Duration(days: 24)), 20, 10),
    ),
    BadgeHistory(
      id: 'badge_first_retro',
      badgeKey: 'first_retro',
      title: '첫 회고 작성',
      description: '한 번의 회고로 다음 계획을 개선했습니다.',
      iconKey: 'insights',
      achievedAt: _at(today.subtract(const Duration(days: 2)), 21, 0),
    ),
  ];
}
