import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/archive/archive_screen.dart';
import '../features/brief/brief_view_screen.dart';
import '../features/brief/today_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/settings/methodology_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/streak/streak_controller.dart';
import 'scaffold_with_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/today',
    redirect: (context, state) async {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      final onboarded = prefs.getBool(kOnboardingCompleteKey) ?? false;
      final goingToOnboarding = state.matchedLocation == '/onboarding';

      if (!onboarded && !goingToOnboarding) return '/onboarding';
      if (onboarded && goingToOnboarding) return '/today';
      return null;
    },
    routes: [
      // Outside the shell: onboarding owns the whole screen, with no way to
      // navigate off it until it's finished.
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),

      // The three primary destinations, each its own branch so their stacks
      // survive tab switches.
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/today', builder: (_, _) => const TodayScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/archive', builder: (_, _) => const ArchiveScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen())],
          ),
        ],
      ),

      // Pushed onto the root navigator, so they cover the nav bar. Reading a
      // brief is a full-screen card stack — a tab bar under it would both
      // compete with the swipe gesture and invite bailing out mid-story.
      GoRoute(
        path: '/brief/:briefId',
        builder: (_, state) => BriefViewScreen(briefId: state.pathParameters['briefId']!),
      ),
      GoRoute(path: '/methodology', builder: (_, _) => const MethodologyScreen()),
    ],
  );
});
