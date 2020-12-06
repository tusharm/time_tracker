import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String text,
  String cancelActionText,
  @required actionText,
}) {

  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              if (cancelActionText != null)
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelActionText),
                ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(actionText),
              ),
            ],
          );
        });
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              if (cancelActionText != null)
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelActionText),
                ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(actionText),
              ),
            ],
          );
        });
  }
}
