import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'app/theme.dart';

void main() {
  runApp(const ProviderScope(child: CivixApp()));
}

class CivixApp extends ConsumerWidget {
  const CivixApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Civix',
      debugShowCheckedModeBanner: false,
      theme: CivixTheme.light(),
      darkTheme: CivixTheme.dark(),
      routerConfig: router,
    );
  }
}
