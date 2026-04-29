# Agile Life

Agile Life is a Flutter app for managing long-term personal goals through short execution cycles. It breaks a goal into milestones, sprints, tasks, and retrospectives, then keeps motivation visible through XP, levels, streaks, and badges.

## Product Focus

Most to-do apps are optimized for short daily lists. Agile Life is designed for goals that need repeated planning, execution, and reflection. The app keeps the current sprint, today's tasks, goal progress, and growth stats visible from the first screen.

## Core Features

- Goal, milestone, sprint, task, retrospective structure
- Minimal dashboard for today's focus and execution list
- Goal list, goal detail, and goal creation flow
- Sprint detail with task checklist and progress tracking
- Retrospective form for reflecting on each sprint
- XP, level, streak, and badge system
- Repository abstraction prepared for a future remote data source

## Screenshots

Screenshots captured from the Flutter web target are stored in `screenshots/`.

- `screenshots/final-dashboard-top-mobile.png`
- `screenshots/final-onboarding-mobile.png`
- `screenshots/final-goals-mobile.png`
- `screenshots/final-goal-detail-mobile.png`
- `screenshots/final-goal-create-mobile.png`
- `screenshots/final-sprints-mobile.png`
- `screenshots/final-sprint-mobile.png`
- `screenshots/final-retrospective-mobile.png`
- `screenshots/final-profile-mobile.png`

## Tech Stack

- Flutter / Dart
- Material 3
- flutter_riverpod
- go_router
- intl
- Repository Pattern
- Local in-memory data source

## Structure

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

## Current Status

The app has a complete MVP screen flow with local state:

- App shell and bottom navigation
- Monochrome Material 3 design system
- Dashboard, goals, sprint detail, retrospective, and profile screens
- Korean service copy throughout the app UI
- Goal creation, task completion, retrospective save interactions
- XP, level, streak, and badge updates

Data is currently local and in-memory. It resets when the app restarts.

## Run

```bash
flutter pub get
flutter run
```

For a quick browser preview:

```bash
flutter run -d web-server --web-port 57321 --web-hostname 127.0.0.1
```

## Verification

- `flutter analyze` passes.
- Main mobile screens were visually checked through the Flutter web target.
- Automated widget tests and iOS/Android device builds are still planned.
