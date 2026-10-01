import 'package:robsic/src/modules/home/domain/domain.dart';

import '../../../core/core.dart';

class PartnershipsSectionAdapter {
  const PartnershipsSectionAdapter._internal();

  static PartnershipsSectionEntity fromMap(Map<String, dynamic> map) {
    try {
      return PartnershipsSectionEntity(
        title: map['title'],
        images: map['images']?['data'] != null
            ? ImageAdapter.fromList(map['images']?['data'])
            : null,
      );
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw (FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }
}
