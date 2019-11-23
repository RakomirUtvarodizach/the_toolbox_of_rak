import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/firestoreAttic.dart';
import 'package:toolbox/red_cross/moneySaver.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MoneySaver _ms = MoneySaver();
  //create user obj based on FirebaseUser
  UserSingleton _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? UserSingleton(uid: user.uid, isVerified: user.isEmailVerified)
        : null;
  }

  //auth change user stream
  Stream<UserSingleton> get user {
    var authUser = _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Log in anonymously
  // Future logInAnon() async {
  //   try {
  //     AuthResult ar = await _auth.signInAnonymously();
  //     FirebaseUser user = ar.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     debugPrint("Log in anon error: " + e.toString());
  //     return null;
  //   }
  // }

  // Log in with email & password
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult aResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = aResult.user;
      if (user != null) {
        _ms.updateSingletonUser("users", user.uid);
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint("Error while logging in: " + e.toString());
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      AuthResult aResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = aResult.user;
      await FirestoreAttic(uid: user.uid)
          .initializeUser(email, firstName, lastName);

      try {
        await user.sendEmailVerification();
        return _userFromFirebaseUser(user);
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }
      return null;
    } catch (e) {
      debugPrint("Register with email and password error : " + e.toString());
      return null;
    }
  }

  // Log out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint("Log out error: " + e.toString());
      return null;
    }
  }
}
