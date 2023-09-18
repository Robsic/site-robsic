import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:robsic/src/app.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/about/about.dart';
import 'package:robsic/src/modules/core/core.dart';

GetIt serviceLocator = GetIt.instance;

void initDependencies() async {
  // httpCLient
  serviceLocator.registerLazySingleton<Dio>(() => dioClient());
  serviceLocator.registerLazySingleton<HttpClientService>(
      () => DioHttpService(serviceLocator.get<Dio>()));

  //datasources
  serviceLocator.registerLazySingleton<AboutDatasource>(
      () => AboutDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<AboutRepository>(
      () => AboutRepositoryImpl(serviceLocator.get<AboutDatasource>()));
  serviceLocator.registerLazySingleton<GetAboutPageDataUsecase>(
      () => GetAboutPageDataUsecase(serviceLocator.get<AboutRepository>()));
  serviceLocator.registerSingleton<AboutStore>(
      AboutStore(serviceLocator.get<GetAboutPageDataUsecase>()));
}

void main() {
  initDependencies();
  runApp(const App());
}
