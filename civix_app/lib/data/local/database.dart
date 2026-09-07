import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// Cached briefs, keyed by [briefId]. Storing the whole brief as one JSON
/// blob (rather than normalizing stories/citations into their own tables)
/// is a deliberate simplification — a brief is read wholesale, never
/// queried story-by-story, so there's no join this schema would save us.
class CachedBriefs extends Table {
  TextColumn get briefId => text()();
  TextColumn get json => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {briefId};
}

@DriftDatabase(tables: [CachedBriefs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor for an in-memory database — see
  /// test/data/local/brief_dao_test.dart.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'civix_briefs.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
