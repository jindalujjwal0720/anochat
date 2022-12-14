// ignore_for_file: avoid_print

import 'package:anochatapp/helper/helperfuncs.dart';
import 'package:anochatapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AnoUser? _userFromFirebaseUser(User? user) {
    return user != null ? AnoUser(userID: user.uid) : null;
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      HelperFunctions.saveUserLoggedInSharedPrefference(false);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
