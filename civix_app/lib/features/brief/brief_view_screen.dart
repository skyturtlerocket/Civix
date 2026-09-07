import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/brief_providers.dart';
import 'brief_body.dart';

/// Re-opens one past brief from the archive, by id.
class BriefViewScreen extends ConsumerWidget {
  const BriefViewScreen({super.key, required this.briefId});

  final String briefId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final briefAsync = ref.watch(briefByIdProvider(briefId));

    return Scaffold(
      appBar: AppBar(title: Text(briefId)),
      body: briefAsync.when(
        data: (brief) => BriefBody(brief: brief, isToday: false),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Could not load this brief.')),
      ),
    );
  }
}
