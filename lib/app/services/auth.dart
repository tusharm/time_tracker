import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Stream<User> get authStateChangesStream;

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> registerWithEmailAndPassword(String email, String password);

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle(BuildContext context);

  Future<void> signOut();
}

class FirebaseAuthentication implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Stream<User> get authStateChangesStream => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    var credentials = await _firebaseAuth.signInAnonymously();
    return credentials.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    var credential =
        await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return credential.user;
  }

  @override
  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    var credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<User> signInWithGoogle(BuildContext context) async {
    var googleAccount = await _googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      if (googleAuth.idToken != null) {
        var userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERR_MISSING_GOOGLE_TOKEN',
          message: 'Missing Google ID token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERR_USER_ABORTED_SIGNIN',
        message: 'User sign-in aborted',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
