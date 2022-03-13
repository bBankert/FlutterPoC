import 'dart:convert';

class LoginInformation{
  String username;
  String password;

  LoginInformation({required this.username,required this.password});

  Map<String,dynamic> toJson() => {
    'username': username,
    'password': password,
  };

  factory LoginInformation.fromJson(Map<String, dynamic> json){
    return LoginInformation(
      username: json['username'],
      password: json['password'],
    );
  }

  factory LoginInformation.decodeInformation(String encodedInformation){
    Map<String,dynamic> map = jsonDecode(encodedInformation);
    return LoginInformation.fromJson(map);
  }

}