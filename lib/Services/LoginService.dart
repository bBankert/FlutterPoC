import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled/Models/LoginInformation.dart';
import 'package:untitled/Models/UserInformation.dart';

import '../Interceptors/LoginInterceptor.dart';

class LoginService {
    Future<UserInformation?> Login(String username,String password) async {
      dynamic userInformation;
      try{
        Dio client = Dio();
        client.interceptors.add(LoginInterceptor());
        final response = await client.request(
          "http://test.com/login",
          data: jsonEncode(LoginInformation(username: username, password: password)),
          options: Options(method: 'POST')
        );
        if(response.statusCode == 200){
          userInformation = response.data;
        }
      }
      catch(e){
        print(e);
      }
      return userInformation;
    }
}
