import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    @required this.auth,
    @required this.signedOut,
  }) : super(key: key);

  final AuthBase auth;
  final VoidCallback signedOut;

  Future<void> _signOut() async {
    await this.auth.signOut();
    signedOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
