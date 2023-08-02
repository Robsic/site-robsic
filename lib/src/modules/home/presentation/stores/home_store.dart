import 'package:flutter/material.dart';
import 'package:robsic/src/modules/home/domain/usecases/get_home_data_usecase.dart';
import 'package:robsic/src/modules/home/presentation/stores/home_states.dart';

class HomeStore extends ValueNotifier<HomeState> {
  HomeStore(this._getHomeDataUsecase) : super(const HomeStateIdle());

  final GetHomeDataUsecase _getHomeDataUsecase;

  Future<void> getHomeData() async {
    value = const HomeStateLoading();
    final result = await _getHomeDataUsecase();
    result.fold(
      (entity) => value = HomeStateSuccess(entity),
      (failure) => value = HomeStateFailure(failure),
    );
  }
}
