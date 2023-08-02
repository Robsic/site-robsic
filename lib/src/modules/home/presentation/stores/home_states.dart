import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/home/domain/entities/home_page_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeStateIdle extends HomeState {
  const HomeStateIdle();
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading();
}

class HomeStateSuccess extends HomeState {
  final HomePageEntity homePageData;

  HomeStateSuccess(this.homePageData);
}

class HomeStateFailure extends HomeState {
  final AppFailure failure;

  HomeStateFailure(this.failure);
}
