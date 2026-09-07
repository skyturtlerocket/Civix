import 'package:civix_app/data/local/brief_dao.dart';
import 'package:civix_app/data/local/database.dart';
import 'package:civix_app/data/models/brief.dart';
import 'package:civix_app/data/remote/brief_api.dart';
import 'package:civix_app/data/repository/brief_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBriefApi extends Mock implements BriefApi {}

Brief _brief(String id) => Brief(
      briefId: id,
      publishedAt: DateTime.utc(2026, 9, 1, 10),
      schemaVersion: 1,
      stories: const [],
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBriefApi api;
  late AppDatabase db;
  late BriefDao dao;
  late BriefRepository repo;

  setUp(() {
    api = MockBriefApi();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = BriefDao(db);
    repo = BriefRepository(api: api, dao: dao, useBundledFallback: true);
  });

  tearDown(() async {
    await db.close();
  });

  group('fetchToday', () {
    test('returns and caches the network result when the network succeeds', () async {
      final networkBrief = _brief('2026-09-05');
      when(() => api.fetchLatest()).thenAnswer((_) async => networkBrief);

      final result = await repo.fetchToday();

      expect(result.briefId, '2026-09-05');
      final cached = await dao.load('2026-09-05');
      expect(cached, isNotNull, reason: 'a successful fetch must be cached for offline use');
    });

    test('falls back to the cache when the network fails', () async {
      await dao.save(_brief('2026-09-04'));
      when(() => api.fetchLatest()).thenThrow(Exception('network down'));

      final result = await repo.fetchToday();

      expect(result.briefId, '2026-09-04');
    });

    test('falls back to a bundled sample brief when both network and cache are empty', () async {
      when(() => api.fetchLatest()).thenThrow(Exception('network down'));
      // no dao.save() call — cache is empty

      final result = await repo.fetchToday();

      expect(
        ['2026-09-01', '2026-08-31'].contains(result.briefId),
        isTrue,
        reason: 'should resolve to one of the bundled sample briefs',
      );
    });

    test('prefers the network result over a stale cache when both are available', () async {
      await dao.save(_brief('2026-08-20')); // stale
      final freshBrief = _brief('2026-09-05');
      when(() => api.fetchLatest()).thenAnswer((_) async => freshBrief);

      final result = await repo.fetchToday();

      expect(result.briefId, '2026-09-05');
    });
  });

  group('fetchByDate', () {
    test('reads from cache without touching the network when already cached', () async {
      await dao.save(_brief('2026-09-01'));

      final result = await repo.fetchByDate('2026-09-01');

      expect(result.briefId, '2026-09-01');
      verifyNever(() => api.fetchByDate(any()));
    });

    test('fetches from network and caches when not already cached', () async {
      final networkBrief = _brief('2026-09-02');
      when(() => api.fetchByDate('2026-09-02')).thenAnswer((_) async => networkBrief);

      final result = await repo.fetchByDate('2026-09-02');

      expect(result.briefId, '2026-09-02');
      expect(await dao.load('2026-09-02'), isNotNull);
    });
  });
}
