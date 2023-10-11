import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:robsic/src/app.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/about/about.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';
import 'package:robsic/src/modules/home/external/datasources/datasources.dart';
import 'package:robsic/src/modules/home/infra/infra.dart';
import 'package:robsic/src/modules/home/presentation/stores/home_store.dart';
import 'package:robsic/src/modules/members/domain/domain.dart';
import 'package:robsic/src/modules/members/external/datasources/datasources.dart';
import 'package:robsic/src/modules/members/infra/infra.dart';
import 'package:robsic/src/modules/members/presentation/stores/members_store.dart';
import 'package:robsic/src/modules/projects/domain/domain.dart';
import 'package:robsic/src/modules/projects/external/datasources/datasources.dart';
import 'package:robsic/src/modules/projects/infra/infra.dart';
import 'package:robsic/src/modules/projects/presentation/stores/projects_store.dart';
import 'package:robsic/src/modules/publications/domain/domain.dart';
import 'package:robsic/src/modules/publications/external/datasources/publications_datasource_impl.dart';
import 'package:robsic/src/modules/publications/infra/datasources/datasources.dart';
import 'package:robsic/src/modules/publications/infra/repositories/publications_repository_impl.dart';
import 'package:robsic/src/modules/publications/presentation/presentation.dart';

GetIt serviceLocator = GetIt.instance;

void initDependencies() async {
  // httpCLient
  serviceLocator.registerLazySingleton<Dio>(() => dioClient());

  //services
  serviceLocator.registerLazySingleton<HttpClientService>(
      () => DioHttpService(serviceLocator.get<Dio>()));
  serviceLocator
      .registerLazySingleton<UrlLauncherDriver>(() => UrlLauncherDriverImpl());

  //datasources
  serviceLocator.registerLazySingleton<AboutDatasource>(
      () => AboutDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<MembersDatasource>(
      () => MembersDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<ProjectsDatasource>(
      () => ProjectsDatasourceImpl(serviceLocator.get<HttpClientService>()));
  serviceLocator.registerLazySingleton<PublicationsDatasource>(() =>
      PublicationsDatasourceImpl(serviceLocator.get<HttpClientService>()));

  //repositories
  serviceLocator.registerLazySingleton<AboutRepository>(
      () => AboutRepositoryImpl(serviceLocator.get<AboutDatasource>()));
  serviceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator.get<HomeDatasource>()));
  serviceLocator.registerLazySingleton<MembersRepository>(
      () => MembersRepositoryImpl(serviceLocator.get<MembersDatasource>()));
  serviceLocator.registerLazySingleton<ProjectsRepository>(
      () => ProjectsRepositoryImpl(serviceLocator.get<ProjectsDatasource>()));
  serviceLocator.registerLazySingleton<PublicationsRepository>(() =>
      PublicationsRepositoryImpl(serviceLocator.get<PublicationsDatasource>()));

  //usecases
  serviceLocator.registerLazySingleton<GetAboutPageDataUsecase>(
      () => GetAboutPageDataUsecase(serviceLocator.get<AboutRepository>()));
  serviceLocator.registerLazySingleton<GetHomeDataUsecase>(
      () => GetHomeDataUsecase(serviceLocator.get<HomeRepository>()));
  serviceLocator.registerLazySingleton<GetMembersDataUsecase>(
      () => GetMembersDataUsecase(serviceLocator.get<MembersRepository>()));
  serviceLocator.registerLazySingleton<GetMembersListUsecase>(
      () => GetMembersListUsecase(serviceLocator.get<MembersRepository>()));
  serviceLocator.registerLazySingleton<GetProjectsDataUsecase>(
      () => GetProjectsDataUsecase(serviceLocator.get<ProjectsRepository>()));
  serviceLocator.registerLazySingleton<GetProjectsListUsecase>(
      () => GetProjectsListUsecase(serviceLocator.get<ProjectsRepository>()));
  serviceLocator.registerLazySingleton<GetPublicationsPageDataUsecase>(() =>
      GetPublicationsPageDataUsecase(
          serviceLocator.get<PublicationsRepository>()));
  serviceLocator.registerLazySingleton<GetPublicationsListUsecase>(() =>
      GetPublicationsListUsecase(serviceLocator.get<PublicationsRepository>()));

  //stores
  serviceLocator.registerSingleton<AppStore>(AppStore());
  serviceLocator.registerSingleton<AppMenusStore>(AppMenusStore());
  serviceLocator.registerSingleton<AboutStore>(
      AboutStore(serviceLocator.get<GetAboutPageDataUsecase>()));
  serviceLocator.registerLazySingleton<HomeStore>(
      () => HomeStore(serviceLocator.get<GetHomeDataUsecase>()));
  serviceLocator.registerLazySingleton<MembersStore>(() => MembersStore(
      serviceLocator.get<GetMembersDataUsecase>(),
      serviceLocator.get<GetMembersListUsecase>()));
  serviceLocator.registerLazySingleton<ProjectsStore>(() => ProjectsStore(
      serviceLocator.get<GetProjectsDataUsecase>(),
      serviceLocator.get<GetProjectsListUsecase>()));
  serviceLocator.registerLazySingleton<PublicationsStore>(() =>
      PublicationsStore(serviceLocator.get<GetPublicationsPageDataUsecase>(),
          serviceLocator.get<GetPublicationsListUsecase>()));
}

void main() {
  initDependencies();
  runApp(const App());
}
