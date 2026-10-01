import 'dart:developer';

import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';
import '../../infra/infra.dart';

class MembersDatasourceImpl implements MembersDatasource {
  final HttpClientService _clientHttp;

  MembersDatasourceImpl(this._clientHttp);

  @override
  Future<Map<String, dynamic>> getMembersData() async {
    try {
      const path = EndPoints.members;
      final response = await _clientHttp.get(path);
      return response['data']?["attributes"] ?? {};
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getMembersList() async {
    try {
      const path = EndPoints.membersList;
      final response = await _clientHttp.get(path);
      return response;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
