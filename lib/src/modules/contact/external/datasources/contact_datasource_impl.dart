import 'dart:developer';

import '../../../../core/core.dart';
import '../../../core/core.dart';
import '../../infra/infra.dart';

class ContactDatasourceImpl implements ContactDatasource {
  final HttpClientService _httpClient;

  ContactDatasourceImpl(this._httpClient);
  @override
  Future<Map<String, dynamic>> getContactpageData() async {
    try {
      final response = await _httpClient.get(EndPoints.contact);
      return response['data']?["attributes"] ?? {};
    } on AppFailure {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> sendContactMessage(
      Map<String, dynamic> contactMessageData) async {
    try {
      log(contactMessageData.toString());
      await Future.delayed(const Duration(seconds: 2));
      return {};
      // final response =
      // await _httpClient.post(EndPoints.contact, data: contactMessageData);
      // return response['data']?["attributes"] ?? {};
    } on AppFailure {
      rethrow;
    }
  }
}
