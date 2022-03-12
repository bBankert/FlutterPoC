import 'package:flutter/material.dart';
import 'package:untitled/Views/LoginForm.dart';

import '../Repositories/SharedPreferencesRepository.dart';
import 'LoadingModal.dart';

class LoginBase extends StatefulWidget {
  LoginBase({Key? key,required this.initialContext}) : super(key: key);
  BuildContext initialContext;

  @override
  State<LoginBase> createState() => _LoginBaseState();
}

class _LoginBaseState extends State<LoginBase>{

  bool _isLoading = true;
  bool _enrolledInBiometrics = false;

  @override
  void initState(){
    super.initState();
    SharedPreferencesRepository.localStorage.getBooleanValue("BiometricsEnabled").then((bool enabled) {
      setState(() {
        _enrolledInBiometrics = enabled;
        _isLoading = false;
      });
    });
  }


  loadingCallback(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _isLoading ?
      const LoadingModal(loadingText: "Loading please wait..."):
      Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // Will take 50% of screen space,
            child: LoginForm(enrolledInBiometrics: _enrolledInBiometrics,loadingCallback: loadingCallback),
        ),
      )
      ,
    );
  }
}
