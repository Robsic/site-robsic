abstract class ContactDatasource {
  Future<Map<String, dynamic>> getContactpageData();
  Future<Map<String, dynamic>> sendContactMessage(
      Map<String, dynamic> contactMessage);
}
