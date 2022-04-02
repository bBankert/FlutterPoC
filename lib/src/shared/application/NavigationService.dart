import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,Object? args) {
    return navigatorKey.currentState!.pushNamed(routeName,arguments: args);
  }
  
  Future<dynamic> navigateHome(){
    return navigatorKey.currentState!.pushNamedAndRemoveUntil("/", (route) => false);
  }

  Future<dynamic> rerouteTo(Route route,bool Function(Route) predicate){
    return navigatorKey.currentState!.pushAndRemoveUntil(route, predicate);
  }
}