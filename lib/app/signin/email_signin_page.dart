import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

import 'email_signin_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(child: EmailSignInForm(auth: auth)),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
