import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';

enum Status { signedIn, loggedIn, error, initial, loggedOut }

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final remoteConfig = FirebaseRemoteConfig.instance;
  late UserCredential userCredential;
  bool isLoading = false;
  String error = '';
  Status status = Status.initial;
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    error = "";
    status = Status.initial;
    notifyListeners();

    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        print('login');
        status = Status.loggedIn;
        notifyListeners();
      } else {
        status = Status.error;
        error = 'Error Logging In';
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            error = 'No user found for that email.';
            break;
          case 'wrong-password':
            error = 'Wrong password provided for that email.';
            break;
          case 'invalid-email':
            error = 'The email address is badly formatted.';
            break;
          default:
            error = 'An unknown error occurred. Please try again.';
        }
      } else {
        error = e.toString();
      }
      status = Status.error;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    error = "";
    status = Status.initial;
    notifyListeners();
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(Constants.collection)
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
        }).then(
          (value) {
            print('authenticated');
          },
        );
      } else {
        status = Status.error;
        error = 'Error creating account';
        notifyListeners();
        print('unauthenticated');
      }
    } catch (e) {
      status = Status.error;
      error = e.toString();
      notifyListeners();
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    status = Status.initial;
    notifyListeners();
    await _auth.signOut().then(
      (value) {
        status = Status.loggedOut;
        notifyListeners();
      },
    );
  }
}
