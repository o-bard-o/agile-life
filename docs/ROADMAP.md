# Roadmap

## 완료된 단계

### 1. 관련 연구 및 문제 정의

- 장기 목표 관리 앱의 한계와 애자일 기반 개인 목표 관리의 필요성 정리
- Goal → Milestone → Sprint → Task 구조와 회고 기능 방향 설정

### 2. 기능 명세 정리

- 대시보드
- 목표 목록/상세/생성
- Sprint 상세
- Retrospective 작성
- XP/Level/Badge 기반 게이미피케이션

### 3. 데이터 모델 초안 설계

- Goal
- Milestone
- Sprint
- Task
- Retrospective
- UserStats
- BadgeHistory

### 4. Flutter 프로젝트 초안 생성

- 기본 Flutter 프로젝트 생성
- 현재는 구조 개편 및 코드베이스 초안 구성 단계까지 진행

## 현재 진행 중

### 5. Mock 데이터 기반 MVP 초안

- Riverpod + go_router 구조 반영
- repository abstraction 추가
- mock seed data와 in-memory state로 핵심 화면 흐름 구성
- GitHub 업로드 가능한 수준의 문서/구조 정리

## 예정된 단계

### 6. Firebase 연동

- Firebase Auth 도입
- Firestore 기반 Goal/Sprint/Retrospective 저장 구조 설계
- repository 구현체 교체

### 7. 디바이스 테스트

- iOS / Android 환경에서 실제 실행 확인
- 라우팅, 상태 반영, 입력 흐름 검증

### 8. 사용자 평가

- 목표 입력 흐름, Sprint 회고 사용성, 게이미피케이션 반응 수집
- 피드백 기반 UI/기능 개선

### 9. MVP 고도화

- CRUD 확장
- 통계 시각화
- 알림, 습관 추적, 개인화 기능 보완
