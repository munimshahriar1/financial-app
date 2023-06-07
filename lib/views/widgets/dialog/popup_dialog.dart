import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  static Future<void> showCupertinoAlertDialog(
      BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            message,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }
}
