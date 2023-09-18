import 'package:dio/dio.dart';

Dio dioClient() {
  final dio =
      Dio(BaseOptions(baseUrl: const String.fromEnvironment('BASE_URL')));
  return dio;
}
