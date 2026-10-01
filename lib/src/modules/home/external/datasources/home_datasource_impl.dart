import 'dart:developer';

import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';
import '../../infra/infra.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final HttpClientService httpClient;

  HomeDatasourceImpl(this.httpClient);

  @override
  Future<Map<String, dynamic>> getHomeData() async {
    try {
      const path = EndPoints.home;
      final response = await httpClient.get(path);
      return response['data']?["attributes"] ?? {};
    } on AppFailure {
      rethrow;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
