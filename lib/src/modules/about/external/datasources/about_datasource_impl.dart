import 'dart:developer';

import 'package:robsic/src/modules/about/infra/datasources/about_datasource.dart';

import '../../../../core/core.dart';
import '../../../core/infra/infra.dart';

class AboutDatasourceImpl implements AboutDatasource {
  final HttpClientService _clientHttp;

  AboutDatasourceImpl(this._clientHttp);

  @override
  Future<Map<String, dynamic>> getAboutPageData() async {
    try {
      const path = EndPoints.about;
      final response = await _clientHttp.get(path);
      return response['data']?["attributes"] ?? {};
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
