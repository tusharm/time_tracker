import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/signin/signin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: SignInPage(),
    );
  }
}
