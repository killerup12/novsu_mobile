import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' hide Router;
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/api/novsu_client.dart';
import 'package:novsu_mobile/domain/models/models.dart';
import 'package:novsu_mobile/domain/utils/html_converter.dart';
import 'package:novsu_mobile/data/data_management/html_converter_impl.dart';
import 'package:novsu_mobile/data/data_management/memory_access_provider_impl.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../features/navigation/navigation_manager.dart';
import '../features/navigation/navigation_manager_impl.dart';
import '../features/navigation/router.dart';
import '../features/screens/blocs.dart';


final locator = GetIt.instance;

Future<void> initLocator() async {
  _initNavigation();
  _initBlocs();
  _initUtils();
  _initNetwork();
  _initHive();
}

_initNavigation() {
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
          () => GlobalKey<NavigatorState>());

  locator.registerLazySingleton<NavigationManager>(
          () => NavigationManagerImpl(navigatorKey: locator()));

  locator.registerLazySingleton<Router>(() => Router());
}

_initBlocs() {
  locator.registerFactory<SplashBloc>(() => SplashBloc(
      navigationManager: locator(),
      novsuApi: locator()
  ));

  locator.registerFactory<LoginBloc>(() => LoginBloc(
      novsuApi: locator(),
      navigationManager: locator(),
      memoryAccessProvider: locator()
  ));

  locator.registerFactory<HomeBloc>(() => HomeBloc());

  locator.registerFactory<TimingBloc>(() => TimingBloc());

  locator.registerFactory<JournalBloc>(() => JournalBloc());

  locator.registerFactory<TopicalBloc>(() => TopicalBloc());

  locator.registerFactory<ServicesBloc>(() => ServicesBloc(
    novsuApi: locator()
  ));
}

_initUtils() {
  locator.registerLazySingleton<HtmlConverter>(() => HtmlConverterImpl());

  locator.registerLazySingleton<MemoryAccessProvider>(() => MemoryAccessProviderImpl());
}

_initNetwork() {
  Dio dio = Dio(BaseOptions(validateStatus: (status) => true));
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  locator.registerLazySingleton<Dio>(() => dio);

  locator.registerLazySingleton<NovsuApi>(() => NovsuClient(
      dio: locator(),
      htmlConverter: locator()
  ));
}

_initHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init('${appDocumentDir.path}/Hive');
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TimetableAdapter());
  Hive.registerAdapter(StudyDayAdapter());
  Hive.registerAdapter(LessonAdapter());
  Hive.openBox("studentData");
}