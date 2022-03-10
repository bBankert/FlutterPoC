import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Models/UserInformation.dart';
import 'package:untitled/Services/NavigationService.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //route params
    final routeArgs = ModalRoute.of(context)!.settings.arguments as UserInformation;
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Hello ${routeArgs.firstName} ${routeArgs.lastName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width > 500  ?60
                            : MediaQuery.of(context).size.width < 300 ?40: 30,
                    )
                  ),
                  Text("Your date of birth is ${routeArgs.dateOfBirth}",
                      style:TextStyle(fontWeight: FontWeight.bold,
                            fontSize  :MediaQuery.of(context).size.width > 500  ?60
                                : MediaQuery.of(context).size.width < 300 ?40: 30,
                      )
                  )
                ],
              ),
            )

        ),

    );
  }
}

