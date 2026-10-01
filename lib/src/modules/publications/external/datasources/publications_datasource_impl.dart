import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../infra/infra.dart';

class PublicationsDatasourceImpl implements PublicationsDatasource {
  final HttpClientService _clientHttp;

  PublicationsDatasourceImpl(this._clientHttp);

  @override
  Future<Map<String, dynamic>> getPublicationsList() async {
    try {
      final List<dynamic> allData = [];
      int page = 1;
      int pageCount = 1;

      while (page <= pageCount) {
        final path = '${EndPoints.publicationsList}&pagination[page]=$page';
        final response = await _clientHttp.get(path);
        
        final data = response['data'];
        if (data is List) {
          allData.addAll(data);
        }
        
        final meta = response['meta'];
        if (meta != null && meta['pagination'] != null) {
          pageCount = meta['pagination']['pageCount'] ?? 1;
        } else {
          break;
        }
        page++;
      }

      return {
        'data': allData,
        'meta': {
          'pagination': {
            'page': 1,
            'pageSize': allData.length,
            'pageCount': 1,
            'total': allData.length,
          }
        }
      };
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
