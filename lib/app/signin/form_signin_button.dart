import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/custom_raised_button.dart';

class FormSignInButton extends CustomRaisedButton {
  FormSignInButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
    height: 40.0,
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.deepPurple,
    onPressed: onPressed,
  );
}