import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';

Dio dioClient() {
  final dio =
      Dio(BaseOptions(baseUrl: const String.fromEnvironment('BASE_URL')))
        ..interceptors.add(LanguageInteceptor())
        ..interceptors.add(LogInterceptor());
  return dio;
}

class LanguageInteceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final AppStore appStore = serviceLocator.get<AppStore>();
    final String language = appStore.value.fullLanguageCode;
    String url = '${options.path}&locale=$language';
    options.path = url;
    return super.onRequest(options, handler);
  }
}

class LogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('API - req - ${options.method} - ${options.uri.toString()}');
    debugPrint('API - headers - ${options.headers}');
    debugPrint('API - body - ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('API - res - status code: ${response.statusCode}');
    debugPrint('API - data - ${response.data}');
    return super.onResponse(response, handler);
  }
}
