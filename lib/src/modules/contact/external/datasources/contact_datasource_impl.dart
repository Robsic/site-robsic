import '../../../../core/core.dart';
import '../../../core/core.dart';
import '../../infra/infra.dart';

class ContactDatasourceImpl implements ContactDatasource {
  final HttpClientService _httpClient;

  ContactDatasourceImpl(this._httpClient);
  @override
  Future<Map<String, dynamic>> getContactpageData() async {
    try {
      final response =
          await _httpClient.get('${EndPoints.contact}&locale=pt-BR');
      return response['data']?["attributes"] ?? {};
    } on AppFailure {
      rethrow;
    }
  }
}
