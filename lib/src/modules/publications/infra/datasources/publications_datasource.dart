abstract class PublicationsDatasource {
  Future<Map<String, dynamic>> getPublicationsPageData();
  Future<Map<String, dynamic>> getPublicationsList();
}
