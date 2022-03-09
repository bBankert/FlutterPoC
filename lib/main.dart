import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Repositories/SharedPreferencesRepository.dart';
import 'package:untitled/Services/BiometricService.dart';
import 'package:untitled/Services/NavigationService.dart';
import 'package:untitled/Views/LoginBase.dart';

import 'Models/UserInformation.dart';
import 'Services/LoginService.dart';
import 'Views/AuthenticatedPage.dart';

void main() {
  serviceLocator();
  runApp(const MyApp());
}

void serviceLocator(){
  GetIt.instance.registerLazySingleton(() => NavigationService());
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => BiometricsService());
  GetIt.instance.registerLazySingleton(() => SharedPreferencesRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginBase(initialContext: context),
      routes: <String,WidgetBuilder>{
        '/authenticated': (context) => const AuthenticatedPage()
      },
    );
  }
}
