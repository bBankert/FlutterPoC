import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Models/UserInformation.dart';
import 'package:untitled/Repositories/SharedPreferencesRepository.dart';

class LoginInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

     UserInformation testUser = UserInformation(
         firstName: 'tom',
         lastName: 'test',
         dateOfBirth: DateTime.parse(('1990-01-01')
         )
     );
     SharedPreferencesRepository.localStorage.setStringValue("UserInformation",jsonEncode(testUser));
      return handler.resolve(
          Response(
              requestOptions:options,
              statusCode: 200,
              data: testUser
          )
      );
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err);
    return super.onError(err, handler);
  }
}