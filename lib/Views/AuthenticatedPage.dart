import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/Models/UserInformation.dart';
import 'package:untitled/Services/NavigationService.dart';

class AuthenticatedPage extends StatefulWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  State<AuthenticatedPage> createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage>{

  Future<bool?> showLogoutWarning(BuildContext context) async{
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        actions: [
          ElevatedButton(
            child: const Text("cancel"),
            onPressed: () => Navigator.pop(context,false),
          ),
          ElevatedButton(
            child: const Text("confirm"),
            onPressed: () => Navigator.pop(context,true),
          )
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context){
    //route params
    final routeArgs = ModalRoute.of(context)!.settings.arguments as UserInformation;
    //allows us to handle native presses of back button
    return WillPopScope(
      onWillPop: () async {

        final shouldPop = await showLogoutWarning(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
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

      ),
    );
  }
}

