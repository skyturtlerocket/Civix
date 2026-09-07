// App-level smoke test: the real CivixApp, wrapped in a ProviderScope,
// boots to the onboarding screen (no prior onboarding flag set) without
// throwing.
import 'package:civix_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('CivixApp boots to onboarding for a fresh install', (tester) async {
    // Without this, SharedPreferences.getInstance() hangs forever under
    // the test binding (no platform-side handler registered), which
    // stalls the router's onboarding-flag redirect indefinitely.
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: CivixApp()));
    // Let the onboarding-flag check, the router redirect, and the
    // provider chain all settle.
    await tester.pumpAndSettle();

    expect(find.text('Civix'), findsWidgets);
    expect(find.text('Turn on a daily reminder'), findsOneWidget);
  });
}
