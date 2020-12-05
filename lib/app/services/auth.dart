import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;

  Stream<User> get authStateChangesStream;

  Future<User> signIn();

  Future<void> signOut();
}

class AnonymousAuth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> get authStateChangesStream => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signIn() async {
    var credentials = await _firebaseAuth.signInAnonymously();
    return credentials.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
