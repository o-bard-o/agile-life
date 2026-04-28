# Midterm Progress

## Summary

Agile Life has moved from a generated Flutter starter into a working MVP-style app. The repository now includes a real app structure, service-ready UI copy, a minimal monochrome design system, local state interactions, and screenshots that show the current product direction.

## Completed

- Flutter app shell with Material 3 theme
- Bottom navigation and route structure
- Domain models for goals, milestones, sprints, tasks, retrospectives, user stats, and badges
- Repository interfaces and local repository implementations
- Seed data based on the current date so screens stay populated
- Dashboard, goals, sprint detail, retrospective, and profile screens
- Goal creation, task check, retrospective save interactions
- XP, level, streak, and badge calculation
- Documentation and screenshots

## Current Limitations

- Data is local and in-memory.
- User accounts and cloud sync are not connected yet.
- Automated tests are not written yet.
- Native iOS and Android device builds have not been verified in this environment.

## Why Local Data First

The first milestone focuses on product structure and interaction quality. Keeping data local made it possible to complete the screen flow, state boundaries, and repository contracts before adding cloud dependencies. The repository interfaces are already separated so a remote data source can be introduced without rewriting the presentation layer.

## Verified

- Static analysis: `flutter analyze`
- Visual check: Flutter web target through Chrome-sized mobile viewport
