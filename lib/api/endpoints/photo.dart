import 'package:dio/dio.dart';
import 'package:josequal/api/api_client.dart';

class WallpapersEndpoints {
  static String basePathCurated = "/curated";
  static String basePathSearch = "/search";

  static Future<Response> random() {
    return ApiClient.get(
        path: basePathCurated, queryParameters: {"per_page": 50});
  }

  static Future<Response> discover(String value) {
    return ApiClient.get(
        path: basePathSearch,
        queryParameters: {"query": value, "per_page": 20});
  }
}
