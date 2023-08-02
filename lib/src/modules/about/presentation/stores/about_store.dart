import 'package:flutter/material.dart';
import 'package:robsic/src/modules/about/domain/usecases/get_about_page_data_usecase.dart';
import 'package:robsic/src/modules/about/presentation/stores/about_states.dart';

class AboutStore extends ValueNotifier<AboutState> {
  AboutStore(this._getAboutPageDataUsecase) : super(const AboutStateIdle());

  final GetAboutPageDataUsecase _getAboutPageDataUsecase;

  Future<void> getAboutPageData() async {
    value = const AboutStateLoading();
    final result = await _getAboutPageDataUsecase();
    result.fold(
      (entity) => value = AboutStateSuccess(entity),
      (failure) => AboutStateFailure(failure),
    );
  }
}
