import 'dart:io';

import 'package:dio/dio.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/api/private_consts.dart';
import 'package:novsu_mobile/data/server_interaction/responses/signed_in.dart';
import 'package:novsu_mobile/data/server_interaction/server_interaction.dart';
import 'package:novsu_mobile/domain/utils/html_converter.dart';
import 'package:novsu_mobile/domain/models/timetable.dart';

import '../../domain/exceptions/exceptions.dart';

class NovsuClient implements NovsuApi {
  static const postLoginUrl = 'https://portal.novsu.ru/s.login/';

  static const getMailsInfoUrl = 'https://portal.novsu.ru/npe/design/themes/novsu2013/checkMail.php?callback=zimba_jsonp_callback';
  static const getZachetkaUrl = 'https://portal.novsu.ru/studentprogress/i.1292972.0.0/';
  static const getProfilePage = 'https://people.novsu.ru/profiles/html/myProfileView.do?lang=ru_ru';

  static const Map<String, String> requestHeaders= {
    HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Dio dio;
  final HtmlConverter htmlConverter;


  NovsuClient({
    required this.dio,
    required this.htmlConverter,
  });

  @override
  Future<SignedIn> login(Login login) async {
    try {
      Response response;

      response = await dio.post('https://portal.novsu.ru/s.login/',
        options: Options(
          headers: requestHeaders
        ),
        data: {
          'json': '1',
          'uid': login.uid,
          'password': login.password,
          'remember': 'on'
        },
      );
      final json =  _returnResponse(response);

      return SignedIn.fromJSON(json);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future getMainProfilePage() async {
    try {
      final Response response = await dio.get(
          'https://people.novsu.ru/profiles/html/myProfileView.do?lang=ru_ru');

      if (response.redirects.isEmpty) {
        return _returnResponse(response);
      } else {
        throw FetchDataException(
            'You have been redirected to another request!'
        );
      }
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<Timetable> getTimetable(String studentId) async {
    try {
      final theUrl = htmlConverter.extractTimetableLink(
          _returnResponse(await dio.get(
              'http://people.novsu.ru/NovSUScheduleService/ScheduleProxy?',
              queryParameters: {
                  'uid': PrivateConsts.uid //TODO get login from profile
          }
      )));

      final response = htmlConverter.convertHtmlTimetable(
          _returnResponse(await dio.get(theUrl)));

      return response;
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  _handleDioError(DioError dioError) {
    if (dioError.error is SocketException) {
      throw NoInternetConnectionException();
    } else {
      throw dioError.error;
    }
  }

  dynamic _returnResponse(Response  response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      case HttpStatus.badRequest:
        throw BadRequestException(response.toString());
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw UnauthorizedException(response.toString());
      case HttpStatus.notFound:
        throw NotFoundException(response.toString());
      case HttpStatus.internalServerError:
        throw ServerErrorException(response.toString());
      case HttpStatus.serviceUnavailable:
        throw UnavailableErrorException(response.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}