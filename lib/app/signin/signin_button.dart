import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    Color textColor,
    Color color,
    double height,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              color: textColor,
            ),
          ),
          color: color,
          height: 50.0,
          onPressed: onPressed,
        );
}
