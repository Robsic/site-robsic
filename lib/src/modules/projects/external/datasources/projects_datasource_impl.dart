import 'dart:developer';

import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../infra/infra.dart';

class ProjectsDatasourceImpl implements ProjectsDatasource {
  final HttpClientService _clientHttp;

  ProjectsDatasourceImpl(this._clientHttp);

  @override
  Future<Map<String, dynamic>> getProjectsData() async {
    try {
      const path = EndPoints.projects;
      final response = await _clientHttp.get(path);
      return response['data']?["attributes"] ?? {};
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getProjectsList() async {
    try {
      const path = EndPoints.projectsList;
      final response = await _clientHttp.get(path);
      return response;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
