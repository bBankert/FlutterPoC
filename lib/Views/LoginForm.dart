

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Repositories/SharedPreferencesRepository.dart';
import 'package:untitled/Services/LoginService.dart';
import 'package:untitled/Views/AuthenticatedPage.dart';
import 'package:untitled/Views/BiometricPrompt.dart';
import 'package:untitled/Views/LoadingModal.dart';

import '../Models/UserInformation.dart';
import '../Services/NavigationService.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key,required this.loadingCallback}) : super(key: key);
  Function loadingCallback;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final double _iconOffset = 38.0;
  final _sharedPreferenceRepository = GetIt.instance<SharedPreferencesRepository>();

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _decodeUserInformation(String encodedUser){
    Map<String,dynamic> map = jsonDecode(encodedUser);
    return UserInformation.fromJson(map);
  }

  authenticatedCallback(authenticated) async{
    if(authenticated){
      //TODO Move this outside of here and inject earlier if possible
      UserInformation testUser = UserInformation(firstName: "John",
          lastName: "Test",
          dateOfBirth: DateTime.parse("1990-01-01"));

      _sharedPreferenceRepository
          .setValue('UserInformation',
          jsonEncode(testUser),
          ValueType.String);

      String encodedUser = await _sharedPreferenceRepository.getValue("UserInformation", ValueType.String);
      UserInformation user = _decodeUserInformation(encodedUser);
      GetIt.instance<NavigationService>()
          .navigateTo(
          '/authenticated',
          user);
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
                                  Future.delayed(Duration(seconds: 3),() => {
                                    GetIt.instance<LoginService>().Login(_usernameController.text,_passwordController.text)
                                        .then((response) {
                                      widget.loadingCallback();
                                      authenticatedCallback(true);
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
                      BiometricPrompt(biometricAuthenticatedCallback: authenticatedCallback)
                    ],
                  ),
                )
        ),
      ),
    );
  }
}
