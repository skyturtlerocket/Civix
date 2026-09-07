import 'package:dio/dio.dart';

import '../models/brief.dart';

/// Talks to the published-brief CDN — see civix_pipeline/civix/publish.py
/// for what writes `latest.json` and the dated files this reads.
class BriefApi {
  BriefApi({required this.baseUrl, Dio? dio}) : _dio = dio ?? Dio();

  /// e.g. https://cdn.civix.app/briefs — the pipeline's publish.py writes
  /// `{baseUrl}/latest.json` and `{baseUrl}/{brief_id}.json`.
  final String baseUrl;
  final Dio _dio;

  Future<Brief> fetchLatest() async {
    final response = await _dio.get<Map<String, dynamic>>('$baseUrl/latest.json');
    return Brief.fromJson(response.data!);
  }

  Future<Brief> fetchByDate(String briefId) async {
    final response = await _dio.get<Map<String, dynamic>>('$baseUrl/$briefId.json');
    return Brief.fromJson(response.data!);
  }
}
