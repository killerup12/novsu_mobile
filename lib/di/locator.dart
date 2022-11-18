import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' hide Router;
import 'package:get_it/get_it.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/api/novsu_client.dart';
import 'package:novsu_mobile/features/utils/html_converter.dart';
import 'package:novsu_mobile/features/utils/html_converter_impl.dart';

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
}

void _initNavigation() {
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
          () => GlobalKey<NavigatorState>());

  locator.registerLazySingleton<NavigationManager>(
          () => NavigationManagerImpl(navigatorKey: locator()));

  locator.registerLazySingleton<Router>(() => Router());

  locator.registerLazySingleton<HtmlConverter>(() => HtmlConverterImpl());
}

void _initBlocs() {
  locator.registerFactory<SplashBloc>(() => SplashBloc(
    navigationManager: locator(),
    novsuApi: locator()
  ));

  locator.registerFactory<HomeBloc>(() => HomeBloc());

  locator.registerFactory<TimingBloc>(() => TimingBloc());

  locator.registerFactory<JournalBloc>(() => JournalBloc());

  locator.registerFactory<TopicalBloc>(() => TopicalBloc());

  locator.registerFactory<ServicesBloc>(() => ServicesBloc(
    novsuApi: locator()
  ));
}

void _initUtils() {
}

void _initNetwork() {
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