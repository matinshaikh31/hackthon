import 'package:clothing/shared/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCtrl extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool isLoading = false;

  void clearFields() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  /// Sign in user with email & password
  Future<void> loginWithEmail(BuildContext context) async {
    isLoading = true;
    update();

    try {
      final email = emailCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) throw Exception("User not found");

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        showAppSnackBar("User record missing in Firestore");
        return;
      }

      showAppSnackBar("Login successful!");
      clearFields();
      Navigator.of(context).pop(); // or redirect to home
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      showAppSnackBar(e.message ?? "Login failed");
    } catch (e) {
      showAppSnackBar("Something went wrong");
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Register new user
  Future<void> registerWithEmail(BuildContext context) async {
    isLoading = true;
    update();

    try {
      final email = emailCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) throw Exception("Account creation failed");

      await _firestore.collection('users').doc(user.uid).set({
        'email': email,
        'phone': null,
        'name': null,
        'defaultAddressId': null,
        'addresses': {},
        'cartItems': {},
        'favourites': [],
        'password':
            password, // (⚠️ consider hashing or excluding in production)
        'wallet': {'points': 1000},
      });

      showAppSnackBar("Account created!");
      clearFields();
      Navigator.of(context).pop(); // or redirect
    } on FirebaseAuthException catch (e) {
      showAppSnackBar(e.message ?? "Sign up failed");
    } catch (e) {
      showAppSnackBar("Something went wrong");
    } finally {
      isLoading = false;
      update();
    }
  }
}
