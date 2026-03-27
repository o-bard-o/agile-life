import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/app_providers.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/goals/presentation/goal_create_screen.dart';
import '../../features/goals/presentation/goal_detail_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/retrospectives/presentation/retrospective_screen.dart';
import '../../features/sprints/presentation/sprint_detail_screen.dart';
import '../../features/sprints/presentation/sprints_screen.dart';
import '../shell/app_shell.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final hasCompletedOnboarding = ref.watch(
    appStateControllerProvider.select((state) => state.hasCompletedOnboarding),
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: hasCompletedOnboarding
        ? AppRoutes.dashboardPath
        : AppRoutes.onboardingPath,
    redirect: (context, state) {
      final isOnboardingRoute =
          state.matchedLocation == AppRoutes.onboardingPath;

      if (!hasCompletedOnboarding && !isOnboardingRoute) {
        return AppRoutes.onboardingPath;
      }

      if (hasCompletedOnboarding && isOnboardingRoute) {
        return AppRoutes.dashboardPath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboardingPath,
        name: AppRoutes.onboardingName,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboardPath,
                name: AppRoutes.dashboardName,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.goalsPath,
                name: AppRoutes.goalsName,
                builder: (context, state) => const GoalsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.sprintsPath,
                name: AppRoutes.sprintsName,
                builder: (context, state) => const SprintsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profilePath,
                name: AppRoutes.profileName,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.goalCreatePath,
        name: AppRoutes.goalCreateName,
        builder: (context, state) => const GoalCreateScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.goalDetailPath,
        name: AppRoutes.goalDetailName,
        builder: (context, state) => GoalDetailScreen(
          goalId: state.pathParameters['goalId']!,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.sprintDetailPath,
        name: AppRoutes.sprintDetailName,
        builder: (context, state) => SprintDetailScreen(
          sprintId: state.pathParameters['sprintId']!,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.retrospectivePath,
        name: AppRoutes.retrospectiveName,
        builder: (context, state) => RetrospectiveScreen(
          sprintId: state.pathParameters['sprintId']!,
        ),
      ),
    ],
  );
});
