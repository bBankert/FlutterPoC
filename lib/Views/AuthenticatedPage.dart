import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Models/UserInformation.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //route params
    final routeArgs = ModalRoute.of(context)!.settings.arguments as UserInformation;
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                Text("Hello ${routeArgs.firstName} ${routeArgs.lastName}"),
                Text("Your date of birth is ${routeArgs.dateOfBirth}")
              ],
            )
        ),

    );
  }
}

