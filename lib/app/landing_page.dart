import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home_page.dart';
import 'package:time_tracker_flutter_course/app/signin/signin_page.dart';

import 'services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key, @required  this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _user;

  @override
  void initState() {
    super.initState();
    _updateUser(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null)
      return SignInPage(
        signedIn: _updateUser,
        auth: widget.auth,
      );
    else
      return HomePage(
        signedOut: () => _updateUser(null),
        auth: widget.auth,
      );
  }

  void _updateUser(user) {
    setState(() {
      this._user = user;
    });
  }
}
