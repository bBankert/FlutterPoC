import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void serviceLocator(){
  GetIt.instance.registerLazySingleton(() => NavigationService());
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => BiometricsService());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{


  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
      navigatorObservers: [routeObserver],
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
      routes: <String,WidgetBuilder>{
        '/': (context) => const LoginBase(),
        '/authenticated': (context) => const AuthenticatedPage()
      },
    );
  }

}
