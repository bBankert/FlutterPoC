import 'package:Flutter_Sandbox/src/features/Authentication/data/authentication_repostiory.dart';
import 'package:Flutter_Sandbox/src/features/Authentication/data/user_repository.dart';
import 'package:Flutter_Sandbox/src/shared/application/NavigationService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

//global instance
final getItInstance = GetIt.instance;


Future initComponents() async {
  //register the repositories
  getItInstance.registerLazySingleton(() => UserRepository());
  getItInstance.registerLazySingleton(() => AuthenticationRepository());


  getItInstance.registerLazySingleton(() => NavigationService());
}