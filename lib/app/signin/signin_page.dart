import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/signin/signin_button.dart';
import 'package:time_tracker/app/signin/social_sign_in_button.dart';

import 'email_signin_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 1.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200], // different shades of material color
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        // vertical alignment
        mainAxisAlignment: MainAxisAlignment.center,

        // stretch along the horizontal axis
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 50.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            asset: 'images/google-logo.png',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () async {
              await auth.signInWithGoogle();
            },
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {
              _signInWithEmail(context);
            },
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go Anonymous',
            textColor: Colors.black87,
            color: Colors.lime[300],
            onPressed: () async {
              await auth.signInAnonymously();
            },
          ),
        ],
      ),
    );
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(auth: auth),
    ));
  }
}

