

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Repositories/SharedPreferencesRepository.dart';
import 'package:untitled/Services/BiometricService.dart';
import 'package:untitled/Services/LoginService.dart';
import 'package:untitled/Views/BiometricPrompt.dart';

import '../Models/UserInformation.dart';
import '../Services/NavigationService.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key,required this.enrolledInBiometrics,required this.loadingCallback}) : super(key: key);
  Function loadingCallback;
  bool enrolledInBiometrics;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final double _iconOffset = 38.0;
  bool _biometricEnabled = false;

  @override
  void initState(){
    super.initState();

  }

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  setBiometricEnabled(enabled){
    _biometricEnabled = enabled;
  }

  login(authenticated) async{
    if(authenticated){
      if(_biometricEnabled){
        bool biometricsEnabled = await GetIt.instance<BiometricsService>().authenticate();
        if(biometricsEnabled){
          print("Enrolled in biometric auth");
        }
      }

      SharedPreferencesRepository.localStorage.getStringValue("UserInformation")
      .then((String encodedUser){
          if(encodedUser.isNotEmpty){
            UserInformation user = UserInformation.decodeUserInformation(encodedUser);
            GetIt.instance<NavigationService>()
                .navigateTo(
                '/authenticated',
                user);
          }
        });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:
      Scaffold(
        body:
          Center(
            child:
                SingleChildScrollView( // center vertically
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'What is your username?',
                            labelText: 'Username'
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'The username field cannot be empty';
                          }
                          return null;
                        },
                        controller: _usernameController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: _iconOffset),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'What is your password?',
                              labelText: 'Password'
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'The password field cannot be empty';
                            }
                            return null;
                          },
                          controller: _passwordController,
                        ),
                      ),
                      Padding( // submit button
                        padding: const EdgeInsets.all(30),
                        child: SizedBox(
                          width: double.infinity, // match parent
                          child: Padding(
                            padding: EdgeInsets.only(left: _iconOffset),
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  widget.loadingCallback();
                                  Future.delayed(const Duration(seconds: 3),() => {
                                    GetIt.instance<LoginService>().Login(_usernameController.text,_passwordController.text)
                                        .then((response) {
                                      widget.loadingCallback();
                                      login(response);
                                    })
                                  }
                                  );
                                }
                              },
                              child: const Text('Login'),
                            ),
                          )
                          ),
                        ),
                      widget.enrolledInBiometrics ?
                      const Text("Already enabled biometrics") :
                      BiometricPrompt(biometricAuthenticatedCallback: setBiometricEnabled)
                    ],
                  ),
                )
        ),
      ),
    );
  }

}
