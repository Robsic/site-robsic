import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:robsic/src/app.dart';
import 'package:robsic/src/app_store.dart';

import 'src/modules/about/about.dart';
import 'src/modules/contact/contact.dart';
import 'src/modules/core/core.dart';
import 'src/modules/home/home.dart';
import 'src/modules/members/members.dart';
import 'src/modules/projects/projects.dart';
import 'src/modules/publications/publications.dart';
import 'src/resources/resources.dart';

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
  serviceLocator.registerLazySingleton<ContactDatasource>(
      () => ContactDatasourceImpl(serviceLocator.get<HttpClientService>()));

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
  serviceLocator.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(serviceLocator.get<ContactDatasource>()));

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
  serviceLocator.registerLazySingleton<GetContactPageDataUsecase>(
      () => GetContactPageDataUsecase(serviceLocator.get<ContactRepository>()));
  serviceLocator.registerLazySingleton<SendContactMessageUsecase>(
      () => SendContactMessageUsecase(serviceLocator.get<ContactRepository>()));

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
  serviceLocator.registerLazySingleton<ContactStore>(() => ContactStore(
      serviceLocator.get<GetContactPageDataUsecase>(),
      serviceLocator.get<SendContactMessageUsecase>()));
}

void main() {
  initDependencies();
  runApp(const App());
}
