import '../models/badge_history.dart';
import '../models/goal.dart';
import '../models/milestone.dart';
import '../models/retrospective.dart';
import '../models/sprint.dart';
import '../models/task.dart';
import '../models/user_stats.dart';

DateTime _date(int year, int month, int day) => DateTime(year, month, day);

List<Goal> seedGoals() {
  return [
    Goal(
      id: 'goal_toeic_850',
      title: '토익 850점 달성',
      description: 'LC 약점을 보완하고 실전 시간 관리 루틴을 만들어 6월 안에 850점을 넘긴다.',
      category: '학습',
      status: GoalStatus.focus,
      createdAt: _date(2026, 3, 3),
      targetDate: _date(2026, 6, 30),
      milestones: [
        Milestone(
          id: 'mile_toeic_mock_780',
          title: '모의고사 780점 달성',
          note: 'LC/RC 현재 체력을 확인하는 기준 점수',
          dueDate: DateTime(2026, 3, 18),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_toeic_lc_review',
          title: 'LC 오답 노트 3회독',
          note: '자주 틀리는 발음과 패턴 정리',
          dueDate: DateTime(2026, 4, 8),
          isCompleted: false,
        ),
        Milestone(
          id: 'mile_toeic_real_850',
          title: '실전 시험 850점 도달',
          note: '시험장 루틴까지 점검',
          dueDate: DateTime(2026, 6, 30),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_toeic_active',
          goalId: 'goal_toeic_850',
          title: '2주차 LC 집중 스프린트',
          objective: 'LC 파트 2 오답률을 낮추고 RC 파트 7 시간 감각을 맞춘다.',
          startDate: DateTime(2026, 3, 24),
          endDate: DateTime(2026, 4, 6),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: false,
          tasks: [
            Task(
              id: 'task_toeic_shadowing',
              title: 'LC 파트 2 쉐도잉 20분',
              note: '잘 안 들리는 발음 10개 기록하기',
              dueDate: DateTime(2026, 3, 27),
              isCompleted: false,
              xpReward: 15,
            ),
            Task(
              id: 'task_toeic_mock',
              title: '모의고사 1회분 풀기',
              note: 'RC 파트 7 제한 시간 체크',
              dueDate: DateTime(2026, 3, 27),
              isCompleted: true,
              xpReward: 20,
              completedAt: DateTime(2026, 3, 27, 9, 20),
            ),
            Task(
              id: 'task_toeic_review',
              title: '오답 노트 3개 문장 정리',
              note: '틀린 이유와 다시 풀 전략 적기',
              dueDate: DateTime(2026, 3, 28),
              isCompleted: false,
              xpReward: 15,
            ),
            Task(
              id: 'task_toeic_part7',
              title: 'RC 파트 7 시간 측정 풀이',
              note: '지문당 8분 이내 목표',
              dueDate: DateTime(2026, 3, 29),
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
      description: '과도한 식단보다 지속 가능한 루틴으로 8주 동안 체지방을 낮춘다.',
      category: '건강',
      status: GoalStatus.steady,
      createdAt: _date(2026, 3, 5),
      targetDate: _date(2026, 5, 31),
      milestones: [
        Milestone(
          id: 'mile_weight_check',
          title: '주 4회 운동 루틴 고정',
          note: '헬스장 3회, 걷기 1회',
          dueDate: DateTime(2026, 4, 5),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_weight_minus3',
          title: '3kg 감량',
          note: '체중과 허리둘레 함께 기록',
          dueDate: DateTime(2026, 4, 30),
          isCompleted: false,
        ),
        Milestone(
          id: 'mile_weight_minus5',
          title: '최종 5kg 감량',
          note: '유지 가능한 루틴까지 정착',
          dueDate: DateTime(2026, 5, 31),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_weight_routine',
          goalId: 'goal_weight_loss',
          title: '식단 기록 스프린트',
          objective: '저녁 식단을 안정화하고 주간 운동 빈도를 고정한다.',
          startDate: DateTime(2026, 3, 21),
          endDate: DateTime(2026, 4, 3),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: true,
          tasks: [
            Task(
              id: 'task_weight_walk',
              title: '저녁 식사 후 30분 걷기',
              note: '비 오는 날은 실내 자전거로 대체',
              dueDate: DateTime(2026, 3, 27),
              isCompleted: true,
              xpReward: 10,
              completedAt: DateTime(2026, 3, 27, 20, 40),
            ),
            Task(
              id: 'task_weight_protein',
              title: '단백질 중심 저녁 식단 기록',
              note: '사진과 메모 한 줄 남기기',
              dueDate: DateTime(2026, 3, 28),
              isCompleted: true,
              xpReward: 10,
              completedAt: DateTime(2026, 3, 26, 19, 10),
            ),
            Task(
              id: 'task_weight_gym',
              title: '하체 중심 웨이트 40분',
              note: '스쿼트/런지/레그프레스 루틴',
              dueDate: DateTime(2026, 3, 29),
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
      description: '집중 시간을 회복하기 위해 짧더라도 매일 독서 루틴을 유지한다.',
      category: '습관',
      status: GoalStatus.steady,
      createdAt: _date(2026, 3, 10),
      targetDate: _date(2026, 4, 30),
      milestones: [
        Milestone(
          id: 'mile_reading_week1',
          title: '7일 연속 독서',
          note: '시간보다 루틴 고정이 우선',
          dueDate: DateTime(2026, 3, 17),
          isCompleted: true,
        ),
        Milestone(
          id: 'mile_reading_pages',
          title: '책 1권 완독',
          note: '핵심 문장 5개 메모',
          dueDate: DateTime(2026, 4, 10),
          isCompleted: false,
        ),
      ],
      sprints: [
        Sprint(
          id: 'sprint_reading_focus',
          goalId: 'goal_reading_daily',
          title: '아침 독서 루틴 스프린트',
          objective: '출근 전 20분 독서를 주 5회 이상 지킨다.',
          startDate: DateTime(2026, 3, 24),
          endDate: DateTime(2026, 4, 6),
          status: SprintStatus.active,
          completionBonusAwarded: false,
          retrospectiveCompleted: false,
          tasks: [
            Task(
              id: 'task_reading_today',
              title: '오늘 아침 독서 20분',
              note: '하이라이트 1개 남기기',
              dueDate: DateTime(2026, 3, 27),
              isCompleted: false,
              xpReward: 12,
            ),
            Task(
              id: 'task_reading_summary',
              title: '이번 주 인상 깊은 문장 정리',
              note: '노션 또는 메모앱에 3문장 기록',
              dueDate: DateTime(2026, 3, 30),
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
  return [
    Retrospective(
      id: 'retro_weight_week1',
      goalId: 'goal_weight_loss',
      sprintId: 'sprint_weight_routine',
      wentWell: '저녁 폭식을 줄였고 주간 걷기 루틴이 생각보다 잘 유지됐다.',
      challenges: '퇴근이 늦은 날은 운동 강도를 지키기 어려웠다.',
      keepDoing: '저녁 식단을 사진으로 남기는 방식은 계속 유지한다.',
      changeNext: '주말에 다음 주 운동 시간을 미리 블록한다.',
      createdAt: DateTime(2026, 3, 22, 21, 00),
    ),
  ];
}

UserStats seedUserStats() {
  return UserStats(
    xp: 182,
    level: 2,
    streakDays: 5,
    completedTaskCount: 6,
    createdGoalCount: 3,
    completedSprintCount: 0,
    retrospectiveCount: 1,
    lastActiveAt: DateTime(2026, 3, 27, 8, 40),
  );
}

List<BadgeHistory> seedBadgeHistory() {
  return [
    BadgeHistory(
      id: 'badge_first_goal',
      badgeKey: 'first_goal',
      title: '첫 목표 설정',
      description: '애자일 목표 관리를 시작했습니다.',
      iconKey: 'flag',
      achievedAt: DateTime(2026, 3, 3, 20, 10),
    ),
    BadgeHistory(
      id: 'badge_first_retro',
      badgeKey: 'first_retro',
      title: '첫 회고 작성',
      description: '한 번의 회고를 통해 다음 계획 개선을 시작했습니다.',
      iconKey: 'insights',
      achievedAt: DateTime(2026, 3, 22, 21, 00),
    ),
  ];
}
