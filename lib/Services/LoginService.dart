import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled/Models/LoginInformation.dart';
import 'package:untitled/Models/UserInformation.dart';

import '../Interceptors/LoginInterceptor.dart';

class LoginService {
    final _client = Dio();
    Future<bool> Login(String username,String password) async {
      try{

        _client.interceptors.add(LoginInterceptor());
        final response = await _client.request(
          "http://test.com/login",
          data: jsonEncode(LoginInformation(username: username, password: password)),
          options: Options(method: 'POST')
        );
        if(response.statusCode == 200){
          return true;
        }
      }
      catch(e){
        print(e);
      }
      return false;
    }
}
