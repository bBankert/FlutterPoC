import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({Key? key,required this.loadingText}) : super(key: key);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Text(loadingText),
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
