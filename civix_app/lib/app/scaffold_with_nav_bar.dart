import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The persistent chrome around Civix's three primary destinations.
///
/// [navigationShell] is built by [StatefulShellRoute.indexedStack] in the
/// router, so each destination keeps its own navigation stack — switching
/// tabs and coming back leaves you where you were, rather than rebuilding
/// the branch from its root.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goToBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Past briefs',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      // Re-tapping the destination you're already on pops that branch back
      // to its root — the convention on both platforms.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
