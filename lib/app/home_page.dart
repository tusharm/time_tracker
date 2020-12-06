import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/widgets/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  Future<void> _signOut(BuildContext context) async {
    var confirmed = await showAlertDialog(
      context: context,
      title: 'Sign out',
      text: 'Are you sure you want to sign out?',
      cancelActionText: 'Cancel',
      actionText: 'Yes',
    );

    if (confirmed) await auth.signOut();
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
            onPressed: () {
              _signOut(context);
            },
          )
        ],
      ),
    );
  }
}
