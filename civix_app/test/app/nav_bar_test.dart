// The bottom navigation bar is the app's primary navigation, so these
// cover the two things that would silently break it: the bar not being
// there at all on the primary destinations, and a tab switch not actually
// changing which screen is on top.
//
// The brief providers are overridden throughout. Left real they reach for
// Drift (via path_provider) and the CDN, neither of which has a platform
// implementation under the test binding — the screens would sit on a
// CircularProgressIndicator, whose endless animation makes pumpAndSettle
// time out rather than fail on anything navigation-related.
import 'package:civix_app/data/models/brief.dart';
import 'package:civix_app/data/repository/brief_providers.dart';
import 'package:civix_app/features/onboarding/onboarding_screen.dart';
import 'package:civix_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Brief _emptyBrief(String id) => Brief(
      briefId: id,
      publishedAt: DateTime.utc(2026, 9, 5, 10),
      schemaVersion: 1,
      stories: const [],
    );

Future<void> pumpOnboardedApp(WidgetTester tester) async {
  // Past onboarding, the router lands on /today — which is inside the shell.
  SharedPreferences.setMockInitialValues({kOnboardingCompleteKey: true});
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        todayBriefProvider.overrideWith((ref) async => _emptyBrief('2026-09-05')),
        archiveProvider.overrideWith((ref) async => <Brief>[]),
      ],
      child: const CivixApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the nav bar shows all three primary destinations', (tester) async {
    await pumpOnboardedApp(tester);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Past briefs'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('tapping a destination switches the screen under it', (tester) async {
    await pumpOnboardedApp(tester);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Daily reminder'), findsOneWidget);

    // The bar stays put across the switch — that's the point of the shell.
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Past briefs'));
    await tester.pumpAndSettle();
    expect(find.text('No past briefs cached yet.'), findsOneWidget);
  });

  testWidgets('onboarding has no nav bar', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: CivixApp()));
    await tester.pumpAndSettle();

    expect(find.text('Turn on a daily reminder'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
