import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:robsic/src/modules/core/core.dart';

class DioHttpService implements HttpClientService {
  final Dio clientHttp;

  DioHttpService(this.clientHttp);

  @override
  Future<Map<String, dynamic>> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    try {
      Map<String, dynamic> newQueryParameters =
          clientHttp.options.queryParameters;
      newQueryParameters.addAll(queryParameters ?? {});

      final response =
          await clientHttp.get(path, queryParameters: newQueryParameters);
      return response.data;
    } on DioException catch (error, stackTrace) {
      if (error.type == DioExceptionType.connectionError) {
        throw ConnectionFailure(error: error, stackTrace: stackTrace);
      } else {
        log(error.toString());
        rethrow;
      }
    }
  }

  @override
  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Map<String, dynamic> newQueryParameters =
          clientHttp.options.queryParameters;
      newQueryParameters.addAll(queryParameters ?? {});

      final response = await clientHttp.post(path,
          data: data, queryParameters: newQueryParameters);
      return response.data;
    } on DioException catch (error, stackTrace) {
      if (error.type == DioExceptionType.connectionError) {
        throw ConnectionFailure(error: error, stackTrace: stackTrace);
      } else {
        log(error.toString());
        rethrow;
      }
    }
  }
}
