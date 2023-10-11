import 'package:robsic/src/modules/core/core.dart';

import '../../../../core/core.dart';
import '../../infra/infra.dart';

class PublicationsDatasourceImpl implements PublicationsDatasource {
  final HttpClientService _clientHttp;

  PublicationsDatasourceImpl(this._clientHttp);

  @override
  Future<Map<String, dynamic>> getPublicationsList() async {
    try {
      const path = EndPoints.publicationsList;
      final response = await _clientHttp.get(path);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPublicationsPageData() async {
    try {
      const path = EndPoints.publications;
      final response = await _clientHttp.get(path);
      return response['data']?["attributes"] ?? {};
    } catch (error) {
      rethrow;
    }
  }
}
