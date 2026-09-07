import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../local/brief_dao.dart';
import '../models/brief.dart';
import '../remote/brief_api.dart';

/// Network-first with a cache fallback, per the plan's app verification
/// step ("go airplane mode and confirm the cached brief still opens").
///
/// A third fallback — the bundled sample briefs in assets/sample_briefs —
/// exists only so the app is fully demoable before the pipeline (M1 in
/// the plan) publishes anything real; [useBundledFallback] defaults to
/// true and should be turned off once a real CDN is wired up in M3.
class BriefRepository {
  BriefRepository({
    required this.api,
    required this.dao,
    this.useBundledFallback = true,
  });

  final BriefApi api;
  final BriefDao dao;
  final bool useBundledFallback;

  static const _bundledAssetPaths = [
    'assets/sample_briefs/2026-09-01.json',
    'assets/sample_briefs/2026-08-31.json',
  ];

  Future<Brief> fetchToday() async {
    try {
      final brief = await api.fetchLatest();
      await dao.save(brief);
      return brief;
    } catch (_) {
      final cached = await dao.loadLatest();
      if (cached != null) return cached;
      if (useBundledFallback) return _loadNewestBundled();
      rethrow;
    }
  }

  Future<Brief> fetchByDate(String briefId) async {
    final cached = await dao.load(briefId);
    if (cached != null) return cached;

    try {
      final brief = await api.fetchByDate(briefId);
      await dao.save(brief);
      return brief;
    } catch (_) {
      if (useBundledFallback) {
        final bundled = await _loadAllBundled();
        final match = bundled.where((b) => b.briefId == briefId);
        if (match.isNotEmpty) return match.first;
      }
      rethrow;
    }
  }

  Future<List<Brief>> archive({int limit = 30}) => dao.loadArchive(limit: limit);

  Future<Brief> _loadNewestBundled() async {
    final bundled = await _loadAllBundled();
    bundled.sort((a, b) => b.briefId.compareTo(a.briefId));
    return bundled.first;
  }

  Future<List<Brief>> _loadAllBundled() async {
    final briefs = <Brief>[];
    for (final path in _bundledAssetPaths) {
      final raw = await rootBundle.loadString(path);
      briefs.add(Brief.fromJson(jsonDecode(raw) as Map<String, dynamic>));
    }
    return briefs;
  }
}
