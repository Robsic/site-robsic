import 'package:dio/dio.dart';

Dio dioClient() {
  final dio = Dio(
      BaseOptions(baseUrl: const String.fromEnvironment('BASE_URL'), headers: {
    'ngrok-skip-browser-warning': '1234',
  }));
  //dio.interceptors.add(DioInterceptor());
  return dio;
}
