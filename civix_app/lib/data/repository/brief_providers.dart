import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/brief_dao.dart';
import '../local/database.dart';
import '../models/brief.dart';
import '../remote/brief_api.dart';
import 'brief_repository.dart';

/// The CDN base URL civix_pipeline/civix/publish.py uploads to (see its
/// `publish_to_cdn`). Overridden in dev builds via
/// `--dart-define=CIVIX_CDN_BASE_URL=...`; falls back to a URL that will
/// simply fail every request, which is fine — [BriefRepository] falls
/// through to the bundled sample briefs whenever the network fails.
const _cdnBaseUrl = String.fromEnvironment(
  'CIVIX_CDN_BASE_URL',
  defaultValue: 'https://cdn.civix.app/briefs',
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final briefDaoProvider = Provider<BriefDao>((ref) {
  return BriefDao(ref.watch(appDatabaseProvider));
});

final briefApiProvider = Provider<BriefApi>((ref) {
  return BriefApi(baseUrl: _cdnBaseUrl);
});

final briefRepositoryProvider = Provider<BriefRepository>((ref) {
  return BriefRepository(
    api: ref.watch(briefApiProvider),
    dao: ref.watch(briefDaoProvider),
  );
});

final todayBriefProvider = FutureProvider<Brief>((ref) {
  return ref.watch(briefRepositoryProvider).fetchToday();
});

final archiveProvider = FutureProvider<List<Brief>>((ref) {
  return ref.watch(briefRepositoryProvider).archive();
});

/// Any single brief by its id — used by the archive detail screen to
/// re-open a past brief (the cache is checked first; see
/// [BriefRepository.fetchByDate]).
final briefByIdProvider = FutureProvider.family<Brief, String>((ref, briefId) {
  return ref.watch(briefRepositoryProvider).fetchByDate(briefId);
});
