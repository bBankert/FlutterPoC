import 'dart:convert';

import 'package:Flutter_Sandbox/src/features/Authentication/bloc/authentication_bloc.dart';
import 'package:Flutter_Sandbox/src/features/Authentication/bloc/authentication_state.dart';
import 'package:Flutter_Sandbox/src/features/Authentication/data/authentication_repostiory.dart';
import 'package:Flutter_Sandbox/src/features/Authentication/data/user_repository.dart';
import 'package:Flutter_Sandbox/src/features/Authentication/presentation/login_page.dart';
import 'package:Flutter_Sandbox/src/features/Home/presentation/home_page.dart';
import 'package:Flutter_Sandbox/src/features/Splash/presentation/splash_page.dart';
import 'package:Flutter_Sandbox/src/shared/application/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


import 'package:Flutter_Sandbox/dependency_injection_conatiner.dart' as ioc_container;


//main can be async since the compiler only looks for a method named "main"
Future main() async {
  //register all components with getit
  await ioc_container.initComponents();

  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();



class MyApp extends StatelessWidget {
  MyApp({Key? key,
    AuthenticationRepository? authRepository,
    UserRepository? userRepo}) :
        authenticationRepository = authRepository ?? GetIt.instance.get<AuthenticationRepository>(),
        userRepository = userRepo ?? GetIt.instance.get<UserRepository>(),
        super(key: key);

  late final UserRepository userRepository;
  late final AuthenticationRepository authenticationRepository;


    @override
    Widget build(BuildContext context) {
      // return MaterialApp(
      //           title: 'Flutter Playground',
      //           debugShowCheckedModeBanner: false,
      //           navigatorKey: GetIt.instance.get<NavigationService>().navigatorKey,
      //           navigatorObservers: [routeObserver],
      //           theme: ThemeData(
      //             // This is the theme of your application.
      //             //
      //             // Try running your application with "flutter run". You'll see the
      //             // application has a blue toolbar. Then, without quitting the app, try
      //             // changing the primarySwatch below to Colors.green and then invoke
      //             // "hot reload" (press "r" in the console where you ran "flutter run",
      //             // or simply save your changes to "hot reload" in a Flutter IDE).
      //             // Notice that the counter didn't reset back to zero; the application
      //             // is not restarted.
      //             primarySwatch: Colors.blue,
      //           ),
      //           routes: <String,WidgetBuilder>{
      //             '/': (context) => const LoginBase(),
      //             '/authenticated': (context) => const AuthenticatedPage()
      //           },
      //         );
      return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          ),
          child: AppView(),
        ),
      );
  }
}

class AppView extends StatefulWidget {
  AppView({NavigationService? navService}) :
    navigationService = navService ?? GetIt.instance.get<NavigationService>();

  late final NavigationService navigationService;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigationService.navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                widget.navigationService.rerouteTo(HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                widget.navigationService.rerouteTo(LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}



