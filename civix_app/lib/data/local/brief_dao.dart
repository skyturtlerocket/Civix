import 'dart:convert';

import 'package:drift/drift.dart';

import 'database.dart';
import '../models/brief.dart';

/// Thin read/write wrapper around the CachedBriefs table — the only part
/// of the app that touches Drift directly, so the repository layer never
/// has to know it's SQLite underneath.
class BriefDao {
  BriefDao(this._db);

  final AppDatabase _db;

  Future<void> save(Brief brief) async {
    await _db.into(_db.cachedBriefs).insertOnConflictUpdate(
          CachedBriefsCompanion.insert(
            briefId: brief.briefId,
            json: jsonEncode(brief.toJson()),
            cachedAt: DateTime.now(),
          ),
        );
  }

  Future<Brief?> load(String briefId) async {
    final row = await (_db.select(_db.cachedBriefs)
          ..where((t) => t.briefId.equals(briefId)))
        .getSingleOrNull();
    if (row == null) return null;
    return Brief.fromJson(jsonDecode(row.json) as Map<String, dynamic>);
  }

  /// The most recently cached brief, regardless of id — used as the
  /// offline fallback for "today" when there's no network and no exact
  /// date match yet.
  Future<Brief?> loadLatest() async {
    final query = _db.select(_db.cachedBriefs)
      ..orderBy([(t) => OrderingTerm.desc(t.cachedAt)])
      ..limit(1);
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return Brief.fromJson(jsonDecode(row.json) as Map<String, dynamic>);
  }

  Future<List<Brief>> loadArchive({int limit = 30}) async {
    final query = _db.select(_db.cachedBriefs)
      ..orderBy([(t) => OrderingTerm.desc(t.briefId)])
      ..limit(limit);
    final rows = await query.get();
    return rows
        .map((row) => Brief.fromJson(jsonDecode(row.json) as Map<String, dynamic>))
        .toList();
  }
}
