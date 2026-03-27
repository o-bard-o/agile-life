# Architecture

## 개요

Agile Life는 기능 단위(feature-based)와 계층 분리(layered architecture)를 함께 사용하는 Flutter 애플리케이션 초안입니다. 현재는 mock/in-memory 데이터 소스를 사용하지만, repository interface를 중심으로 구성하여 이후 Firebase Auth / Firestore로 교체할 수 있도록 설계했습니다.

## 계층 구조

### 1. App Layer

- `lib/app`
- 앱 테마, 라우터, 앱 셸을 담당합니다.
- `go_router` 기반으로 온보딩, 탭 내비게이션, 상세 화면 이동을 구성합니다.

### 2. Core Layer

- `lib/core/models`
- 도메인 모델을 정의합니다.

- `lib/core/repositories`
- repository interface를 정의합니다.
- 현재는 UI가 구체 구현을 직접 알지 않도록 abstraction 경계를 제공합니다.

- `lib/core/mock`
- mock repository, seed data, in-memory store를 포함합니다.
- 중간보고서 시점에 필요한 화면 흐름을 빠르게 검증하기 위한 계층입니다.

- `lib/core/services`
- XP, 레벨, 배지 등 게이미피케이션 규칙을 분리합니다.

- `lib/core/providers`
- Riverpod provider 조합 지점을 둡니다.

### 3. Feature Layer

- `lib/features/dashboard`
- 현재 Sprint, 오늘의 Task, 목표 진행률, 최근 배지를 보여주는 홈 화면입니다.

- `lib/features/goals`
- 목표 목록, 상세, 생성 화면을 포함합니다.

- `lib/features/sprints`
- Sprint 목록과 상세 체크리스트를 담당합니다.

- `lib/features/retrospectives`
- 회고 작성/수정 화면을 담당합니다.

- `lib/features/profile`
- XP, Level, streak, badge 등 사용자 통계를 표시합니다.

### 4. Shared Layer

- `lib/shared/widgets`
- 카드, 섹션 헤더, 상태 chip, 태스크 tile 등 공통 UI를 관리합니다.

- `lib/shared/state`
- 앱 전역 state와 상태 제어 흐름을 둡니다.

- `lib/shared/utils`
- 날짜 포맷, status mapping, id 생성 등 범용 유틸리티를 관리합니다.

## 주요 Feature 설명

### Dashboard

- 현재 활성 Sprint
- 오늘 due date 기준 Task
- Goal 진행률 카드
- XP/Level/Streak 요약

### Goals

- Goal 목록 조회
- Goal 상세에서 Milestone / Sprint 구조 확인
- Goal 생성 시 starter sprint/task 자동 구성

### Sprints

- Sprint 보드에서 현재 진행 상황 확인
- Task 체크 시 in-memory state 갱신
- 완료율 80% 이상 달성 시 bonus XP 반영

### Retrospectives

- Sprint 기준 회고 작성
- 잘한 점 / 어려웠던 점 / 유지할 점 / 바꿀 점 구조
- 첫 회고 작성 시 bonus XP 및 badge 조건 반영

### Profile / Gamification

- 누적 XP, Level, streak
- 완료 태스크 수
- badge history

## Repository Pattern 설명

현재 구현은 다음 인터페이스를 기준으로 동작합니다.

- `GoalRepository`
- `SprintRepository`
- `RetrospectiveRepository`
- `StatsRepository`

UI는 Riverpod `AppStateController`를 통해 상태를 읽고 변경합니다. 컨트롤러는 repository 구현체를 직접 알지만, 화면은 repository 구현 세부사항을 모른 채 상태와 액션만 사용합니다. 이 구조 덕분에 향후 mock 구현을 Firestore 구현으로 교체할 때 UI 변경 범위를 줄일 수 있습니다.

## Mock Data를 쓰는 이유

중간보고서 시점에는 다음이 더 중요합니다.

- 기능 의도가 보이는 화면 스켈레톤
- 상태 흐름이 보이는 코드 구조
- 문서화된 아키텍처와 확장 방향

반면 실제 인증/클라우드/디바이스 테스트는 시간과 환경 의존성이 큽니다. 그래서 현재 단계에서는 mock seed data와 in-memory state를 사용해, 핵심 사용자 흐름을 먼저 정리하고 이후 실제 백엔드를 붙일 수 있도록 설계했습니다.

## 향후 Firebase 확장 포인트

- `mockStoreProvider`를 Firestore/remote data source provider로 교체
- `GoalRepository`, `SprintRepository`, `RetrospectiveRepository`, `StatsRepository`의 concrete implementation을 Firebase 기반으로 추가
- 인증 상태에 따라 사용자별 Goal/Sprint/Stats 분리
- 회고/통계 데이터를 Firestore document 구조로 정리
- 필요 시 로컬 캐시 계층 추가

현재 코드에는 향후 Firebase 전환 지점을 보여 주기 위해 관련 TODO 주석을 남겨 두었습니다.
