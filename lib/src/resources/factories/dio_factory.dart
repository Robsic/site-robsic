import 'package:dio/dio.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';

Dio dioClient() {
  final dio =
      Dio(BaseOptions(baseUrl: const String.fromEnvironment('BASE_URL')))
        ..interceptors.add(LanguageInteceptor());
  return dio;
}

class LanguageInteceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final AppStore appStore = serviceLocator.get<AppStore>();
    final String language = appStore.value.fullLanguageCode;
    String url = '${options.path}&locale=$language';
    options.path = url;
    super.onRequest(options, handler);
  }
}
