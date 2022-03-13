import 'package:flutter/material.dart';
import 'package:untitled/Models/LoginInformation.dart';
import 'package:untitled/Models/UserInformation.dart';
import 'package:untitled/Views/BiometricOnlyLoginPage.dart';
import 'package:untitled/Views/LoginForm.dart';

import '../Repositories/SharedPreferencesRepository.dart';
import '../main.dart';
import 'LoadingModal.dart';

class LoginBase extends StatefulWidget {
  const LoginBase({Key? key}) : super(key: key);

  @override
  State<LoginBase> createState() => _LoginBaseState();
}

class _LoginBaseState extends State<LoginBase> with RouteAware{
  bool _isLoading = true;
  bool _enrolledInBiometrics = false;
  late UserInformation _userInformation;
  late LoginInformation _loginInformation;

  @override
  void didPush() {
    //print('HomePage: Called didPush');
    super.didPush();
  }

  @override
  void didPop() {
    //print('HomePage: Called didPop');
    super.didPop();
  }

  @override
  void didPopNext() {
    //print('HomePage: Called didPopNext');
    setState(() {
      _isLoading = true;
    });

    initData().then((bool finishedLoading) => setState((){ _isLoading = false;}));
    
    super.didPopNext();
  }

  Future<bool> initData() async{
    bool enabled = await SharedPreferencesRepository.localStorage.getBooleanValue("BiometricsEnabled");
    String encodedUserInformation = 
      await SharedPreferencesRepository.localStorage.getStringValue("UserInformation");
    String encodedLoginInformation = 
      await SharedPreferencesRepository.localStorage.getStringValue("LoginInformation");
    
    setState(() {
      _enrolledInBiometrics = enabled;
      if(encodedLoginInformation.isNotEmpty){
        _loginInformation = LoginInformation.decodeInformation(encodedLoginInformation);
      }
      if(encodedUserInformation.isNotEmpty){
        _userInformation = UserInformation.decodeInformation(encodedUserInformation);
      }
    });
    
    return true;
  }

  @override
  void didPushNext() {
    //print('HomePage: Called didPushNext');
    super.didPushNext();
  }

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    });

    initData().then((bool finishedLoading) => setState((){ _isLoading = false;}));

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
        child: _enrolledInBiometrics ?
          BiometricOnlyLoginPage(userInformation: _userInformation,loginInformation: _loginInformation) :
          Container(
            width: MediaQuery.of(context).size.width * 0.5, // Will take 50% of screen space,
            child: LoginForm(enrolledInBiometrics: _enrolledInBiometrics,loadingCallback: loadingCallback),
        ),
      )
      ,
    );
  }
}
