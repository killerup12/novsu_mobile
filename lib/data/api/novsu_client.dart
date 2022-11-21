import 'dart:io';

import 'package:dio/dio.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/api/private_consts.dart';
import 'package:novsu_mobile/domain/models/response_fields/user.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:novsu_mobile/data/data_management/html_converter.dart';
import 'package:novsu_mobile/domain/models/timeable_item.dart';

import '../../domain/exceptions/exceptions.dart';

class NovsuClient implements NovsuApi {
  static const postLoginUrl = 'https://portal.novsu.ru/s.login/';
  static const getMailsInfoUrl = 'https://portal.novsu.ru/npe/design/themes/novsu2013/checkMail.php?callback=zimba_jsonp_callback';
  static const getZachetkaUrl = 'https://portal.novsu.ru/studentprogress/i.1292972.0.0/';

  static const Map<String, String> requestHeaders= {
    HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Dio dio;
  final HtmlConverter htmlConverter;


  NovsuClient({
    required this.dio,
    required this.htmlConverter
  });

  @override
  Future<User> login() async {
    try {
      Response response;

      response = await dio.post('https://portal.novsu.ru/s.login/',
        options: Options(
          headers: requestHeaders
        ),
        data: {
          'redirect': 'https://portal.novsu.ru/',
          'json': '1',
          'uid': PrivateConsts.uid,
          'password': PrivateConsts.password,
          'remember': 'on'
        },
      );
      return _returnResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<Timetable> getTimetable() async {
    try {
      final theUrl = htmlConverter.extractTimetableLink((await dio.get(
          'http://people.novsu.ru/NovSUScheduleService/ScheduleProxy?',
          queryParameters: {
            'uid': PrivateConsts.uid //TODO get login from profile
          }
      )).data);

      final response = htmlConverter.convertHtmlTimetable(
          (await dio.get(theUrl)).data);

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

  Map<String, String> _getHeaders(String token) {
    Map<String, String> headers = {}..addAll(requestHeaders);
    return headers;
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