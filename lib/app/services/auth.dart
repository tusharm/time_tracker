import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Stream<User> get authStateChangesStream;

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

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
  Future<User> signInWithGoogle() async {
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
