import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Models/LoginInformation.dart';
import 'package:untitled/Models/UserInformation.dart';
import 'package:untitled/Services/BiometricService.dart';
import 'package:untitled/Services/LoginService.dart';
import 'package:untitled/Services/NavigationService.dart';


class BiometricOnlyLoginPage extends StatelessWidget {
  BiometricOnlyLoginPage({Key? key,
    required this.userInformation,
    required this.loginInformation}) : super(key: key);

  final UserInformation userInformation;
  final LoginInformation loginInformation;

  final BiometricsService _biometricsService = GetIt.instance<BiometricsService>();
  final LoginService _loginService = GetIt.instance<LoginService>();
  final NavigationService _navigationService = GetIt.instance<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Welcome Back! ${userInformation.firstName} ${userInformation.lastName}"),
              ElevatedButton(
                child: const Text("Login with Biometrics"),
                onPressed: (){
                  _biometricsService.authenticate().then((bool authenticated){
                    if(authenticated){
                      _loginService.Login(loginInformation.username, loginInformation.password)
                          .then((bool successfullyLoggedIn){
                        _navigationService
                            .navigateTo(
                            '/authenticated',
                            userInformation);
                      });
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
     );
  }
}
