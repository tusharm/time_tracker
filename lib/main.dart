import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/app/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LandingPage(
        auth: AnonymousAuth(),
      ),
    );
  }
}
