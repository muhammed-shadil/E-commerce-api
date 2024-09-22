import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';

enum Status { signedIn, loggedIn, error, initial, loggedOut }

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        status = Status.loggedIn;
        print('Login successful');
      } else {
        error = 'Authentication failed';
        status = Status.error;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          error = 'No user found for that email.';
          break;
        case 'wrong-password':
          error = 'Incorrect password provided.';
          break;
        case 'invalid-email':
          error = 'The email address is badly formatted.';
          break;
        case 'network-request-failed':
          error = 'No internet connection. Please check your network.';
          break;
        default:
          error = 'Authentication error: ${e.message}';
      }
    } catch (e) {
      error = 'An unexpected error occurred: $e';
    } finally {
      isLoading = false;
      status = status == Status.initial ? Status.error : status;
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
            .set({'uid': user.uid, 'email': user.email, 'name': name});
        status = Status.loggedIn;
        print('User registered successfully');
      } else {
        error = 'Failed to create account.';
        status = Status.error;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          error = 'The email address is already in use by another account.';
          break;
        case 'weak-password':
          error = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          error = 'The email address is badly formatted.';
          break;
        case 'network-request-failed':
          error = 'No internet connection. Please check your network.';
          break;
        default:
          error = 'Registration error: ${e.message}';
      }
    } catch (e) {
      error = 'An unexpected error occurred: $e';
    } finally {
      isLoading = false;
      status = status == Status.initial ? Status.error : status;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    status = Status.initial;
    notifyListeners();

    await _auth.signOut().then((_) {
      status = Status.loggedOut;
      print('User logged out');
      notifyListeners();
    }).catchError((e) {
      error = 'Logout failed: $e';
      status = Status.error;
      notifyListeners();
    });
  }
}
