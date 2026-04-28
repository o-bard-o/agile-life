# Architecture

## Overview

Agile Life uses a feature-first Flutter structure with clear domain, repository, state, and presentation boundaries. The current implementation runs on local in-memory data, but the app is organized so the data source can later move to Firebase or another backend.

## Layers

### App

`lib/app` owns the app shell, router, and theme. `go_router` handles navigation, while the shell provides the bottom navigation used by the main product screens.

### Core

`lib/core/models` contains domain models:

- Goal
- Milestone
- Sprint
- Task
- Retrospective
- UserStats
- BadgeHistory

`lib/core/repositories` defines repository contracts. `lib/core/mock` provides the current local implementations and seed data. `lib/core/services` contains product rules such as XP, level, streak, and badge logic.

### Shared

`lib/shared/state` contains the Riverpod state controller that coordinates repositories and UI state. `lib/shared/widgets` and `lib/shared/utils` hold reusable UI and formatting helpers.

### Features

Each feature owns its presentation layer:

- `dashboard`
- `goals`
- `sprints`
- `retrospectives`
- `gamification`
- `profile`
- `onboarding`

## Repository Pattern

Screens do not read the local data source directly. They interact with `AppStateController`, which coordinates the repository interfaces. This keeps UI code stable when the data layer changes.

Current repositories:

- `GoalRepository`
- `SprintRepository`
- `RetrospectiveRepository`
- `StatsRepository`

## Data Source Strategy

The current data source is local and in-memory. This keeps the product flow fast to review and avoids coupling early UI decisions to cloud schema details. The next step is to add persistence behind the same repository contracts.

## Firebase Extension Point

Firebase can be introduced by adding repository implementations backed by Auth and Firestore, then switching providers in `lib/core/providers/app_providers.dart`.

Recommended direction:

- Authenticate users with Firebase Auth.
- Store goals, sprints, retrospectives, and stats under a user document.
- Keep Riverpod state and screen code unchanged where possible.
- Add sync/loading/error states after the remote layer is connected.
