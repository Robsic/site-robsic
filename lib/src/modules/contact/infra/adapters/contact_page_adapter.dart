import '../../../core/core.dart';
import '../../domain/domain.dart';

class ContactPageAdapter {
  const ContactPageAdapter._internal();

  static ContactPageEntity fromMap(Map<String, dynamic> map) {
    try {
      return ContactPageEntity(
        headerSection:
            map['header'] != null ? HeaderAdapter.fromMap(map['header']) : null,
        image: map['image']?['data']?['attributes'] != null
            ? ImageAdapter.fromMap(map['image']?['data']?['attributes'])
            : null,
      );
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
