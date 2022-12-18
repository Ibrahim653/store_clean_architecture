import 'package:advanced_app/app/app_prefs.dart';
import 'package:advanced_app/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content_type';
const String ACCEPT = 'accept';
const String AUTHORISATION = 'authorization';
const String DEFAULT_LAUGUAGE = 'language';

class DioFactory {
  final AppPreference _appPreference;
  DioFactory(this._appPreference);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language =await _appPreference.getAppLanguage();
    int timeOut = Constants.apiTimeOut; // 1 min timeOut
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORISATION: Constants.token,
      DEFAULT_LAUGUAGE: language, 
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      sendTimeout: timeOut,
      receiveTimeout: timeOut,
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs

      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
