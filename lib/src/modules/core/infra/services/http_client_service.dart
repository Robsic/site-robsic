abstract class HttpClientService {
  Future<Map<String, dynamic>> get(String path,
      [Map<String, dynamic>? queryParameters]);

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });
}
