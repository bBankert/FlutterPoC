import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled/Models/UserInformation.dart';

class LoginInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      return handler.resolve(
          Response(
              requestOptions:options,
              statusCode: 200,
              data:UserInformation(
                  firstName: 'tom',
                  lastName: 'test',
                  dateOfBirth: DateTime.parse(('1990-01-01')
                  )
              )
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