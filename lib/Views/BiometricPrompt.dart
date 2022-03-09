import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:untitled/Services/BiometricService.dart';

import '../Services/NavigationService.dart';

class BiometricPrompt extends StatefulWidget {
  BiometricPrompt({Key? key,required this.biometricAuthenticatedCallback}) : super(key: key);
  Function(bool) biometricAuthenticatedCallback;

  @override
  State<BiometricPrompt> createState() => _BiometricPromptState();
}

class _BiometricPromptState extends State<BiometricPrompt> {
  final bool _isChecked = false;

  Color setCheckboxColor(Set<MaterialState> states){
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }



  @override
  Widget build(BuildContext context) {
    return Row(
         mainAxisAlignment: MainAxisAlignment.end, // x-axis
         crossAxisAlignment: CrossAxisAlignment.center, // y-axis
         children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Enable Biometrics'),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(setCheckboxColor),
          value: _isChecked,
          onChanged: (bool? value) {
            GetIt.instance<BiometricsService>()
                .authenticate()
                .then((authenticated){
                  widget.biometricAuthenticatedCallback(authenticated);
              });
            })
          ]
        );
  }
}
