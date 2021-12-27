import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({required this.uid});
  final String uid;
}

class AuthService {
  final _auth = auth.FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  User? _userFromFirebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
    );
  }

  Stream<User?>? get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
}
