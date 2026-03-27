# Agile Life

Agile Life는 개인의 장기 목표를 `Goal → Milestone → Sprint → Task` 구조로 나누고, Sprint Retrospective와 게이미피케이션 요소(XP, Level, Badge)를 통해 실행 흐름을 관리하는 Flutter 애플리케이션 초안입니다.

## 프로젝트 소개

기존 To-do 앱은 오늘 할 일을 빠르게 정리하는 데는 강하지만, 몇 주 또는 몇 달에 걸친 장기 목표를 꾸준히 관리하기에는 구조가 약한 경우가 많습니다. Agile Life는 개인 목표를 애자일 방식으로 쪼개어, 장기 목표를 작은 실행 단위와 회고 사이클로 연결하는 데 초점을 둡니다.

현재 저장소는 **mock 데이터 기반 MVP 초안**입니다. 화면 흐름, 상태 관리 구조, repository abstraction, 주요 문서화를 먼저 정리했고, 실제 Firebase 연동 및 디바이스 검증은 이후 단계에서 진행할 예정입니다.

## 문제 정의

- 일반적인 To-do 중심 앱은 장기 Goal을 중간 단계(Milestone/Sprint)로 구조화하기 어렵습니다.
- 단순 체크리스트만으로는 어떤 목표가 왜 지연되는지 회고하고 다음 실행 계획으로 연결하기 어렵습니다.
- 장기 목표는 동기 유지가 중요한데, 즉각적인 피드백(XP/Level/Badge)이 부족하면 중도 이탈 가능성이 커집니다.

## 핵심 기능

- Goal, Milestone, Sprint, Task 계층 기반 목표 관리
- 홈 대시보드에서 현재 Sprint, 오늘의 Task, 목표 진행률, XP/Level 요약 확인
- 목표 목록 및 목표 상세 화면
- 목표 생성 시 starter milestone/sprint/task 자동 구성
- Sprint 상세 체크리스트와 진행률 표시
- Sprint Retrospective 작성/수정
- XP, Level, streak, badge 기반 게이미피케이션

## 기술 스택

- Flutter / Dart
- Material 3
- flutter_riverpod
- go_router
- intl
- Repository Pattern
- Mock / In-memory data source

## 폴더 구조

```text
lib/
  app/
    router/
    shell/
    theme/
  core/
    mock/
    models/
    providers/
    repositories/
    services/
  features/
    dashboard/
    gamification/
    goals/
    onboarding/
    profile/
    retrospectives/
    sprints/
  shared/
    state/
    utils/
    widgets/
docs/
  ARCHITECTURE.md
  MIDTERM_PROGRESS.md
  ROADMAP.md
```

## 현재 구현 범위

- 앱 엔트리, Material 3 테마, go_router 기반 라우팅
- 하단 내비게이션이 있는 앱 셸 구조
- Goal / Milestone / Sprint / Task / Retrospective / UserStats / BadgeHistory 모델
- repository interface + mock repository + seed data
- 목표 추가, 태스크 체크, 회고 저장이 in-memory state로 반영되는 흐름
- 게이미피케이션 로직 초안
  - 태스크 완료 시 XP 증가
  - 스프린트 완료율 80% 이상 도달 시 보너스 XP
  - 회고 작성 시 보너스 XP
  - 레벨 계산
  - 기본 배지 4종
- README 및 문서 초안

## 실행 방법

현재 저장소는 코드 구조와 화면 흐름 위주의 초안입니다. 실제 실행은 이후 환경이 준비되면 아래와 같이 진행할 수 있습니다.

```bash
flutter pub get
flutter run
```

## 현재 한계

- Firebase Auth / Firestore 미연동
- 데이터는 mock / in-memory 기준이라 앱 재실행 시 유지되지 않음
- 테스트 코드 미작성
- `flutter test`, 디바이스 빌드, iOS/Android 실기기 검증은 이번 작업에서 수행하지 않음
- 현재 저장소는 MVP 완성본이 아니라 중간보고서 제출용 구조 초안임

## 향후 계획

- Firebase Auth / Firestore 연동
- 목표/스프린트 CRUD 확장
- 통계/회고 분석 화면 고도화
- 실제 iOS/Android 디바이스 테스트
- 사용자 평가 및 피드백 반영
