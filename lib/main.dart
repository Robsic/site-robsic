import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:robsic/src/app.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/about/about.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';
import 'package:robsic/src/modules/home/external/datasources/datasources.dart';
import 'package:robsic/src/modules/home/infra/infra.dart';
import 'package:robsic/src/modules/home/presentation/stores/home_store.dart';

GetIt serviceLocator = GetIt.instance;

void initDependencies() async {
  // httpCLient
  serviceLocator.registerLazySingleton<Dio>(() => dioClient());

  //services
  serviceLocator.registerLazySingleton<HttpClientService>(
      () => DioHttpService(serviceLocator.get<Dio>()));
  serviceLocator
      .registerLazySingleton<LaunchUrlService>(() => LaunchUrlServiceImpl());

  //datasources
  serviceLocator.registerLazySingleton<AboutDatasource>(
      () => AboutDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImpl(serviceLocator.get<HttpClientService>()));

  //repositories
  serviceLocator.registerLazySingleton<AboutRepository>(
      () => AboutRepositoryImpl(serviceLocator.get<AboutDatasource>()));
  serviceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator.get<HomeDatasource>()));

  //usecases
  serviceLocator.registerLazySingleton<GetAboutPageDataUsecase>(
      () => GetAboutPageDataUsecase(serviceLocator.get<AboutRepository>()));
  serviceLocator.registerLazySingleton<GetHomeDataUsecase>(
      () => GetHomeDataUsecase(serviceLocator.get<HomeRepository>()));

  //stores
  serviceLocator.registerSingleton<AboutStore>(
      AboutStore(serviceLocator.get<GetAboutPageDataUsecase>()));
  serviceLocator.registerLazySingleton<HomeStore>(
      () => HomeStore(serviceLocator.get<GetHomeDataUsecase>()));
}

void main() {
  initDependencies();
  runApp(const App());
}
