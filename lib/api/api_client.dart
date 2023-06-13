import 'package:dio/dio.dart';

class ApiClient {
  static String baseHost = "https://api.pexels.com/v1/";

// or new Dio with a BaseOptions instance.
  static BaseOptions options = BaseOptions(
      baseUrl: baseHost,
      listFormat: ListFormat.multiCompatible,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      headers: sharedHeaders());

  static Map<String, String>? sharedHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization":
          "WBduBi2yG4IZc4ZgixYHzLAq5UD0losOGhYmo2Ju2O9Y9FxyTYxZJ69g"
      // shared headers
    };
  }

  static Future<Response> get(
      {String? path, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await Dio(options).get(path!, queryParameters: queryParameters);
      return response;
    } catch (error) {
      throw Exception('Failed to perform GET request: $error');
    }
  }

  // Future<Response> post(String url, dynamic data) async {
  //   try {
  //     final response = await Dio(options).post(url, data: data);
  //     return response;
  //   } catch (error) {
  //     throw Exception('Failed to perform POST request: $error');
  //   }
  // }

  // Future<Response> put(String url, dynamic data) async {
  //   try {
  //     final response = await Dio(options).put(url, data: data);
  //     return response;
  //   } catch (error) {
  //     throw Exception('Failed to perform PUT request: $error');
  //   }
  // }

  // Future<Response> delete(String url) async {
  //   try {
  //     final response = await Dio(options).delete(url);
  //     return response;
  //   } catch (error) {
  //     throw Exception('Failed to perform DELETE request: $error');
  //   }
  // }
}
