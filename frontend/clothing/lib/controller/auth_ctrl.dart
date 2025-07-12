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

  // Use RxBool for reactive state management
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void clearFields() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  // Add input validation
  bool _validateInputs() {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showAppSnackBar("Please fill in all fields");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      showAppSnackBar("Please enter a valid email address");
      return false;
    }

    if (password.length < 6) {
      showAppSnackBar("Password must be at least 6 characters long");
      return false;
    }

    return true;
  }

  /// Sign in user with email & password
  Future<void> loginWithEmail(BuildContext context) async {
    if (!_validateInputs()) return;

    _isLoading.value = true;

    try {
      final email = emailCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) throw Exception("User not found");

      // Check if user document exists in Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        showAppSnackBar("User record missing in Firestore");
        return;
      }

      showAppSnackBar("Login successful!");
      clearFields();

      // Better navigation handling
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Get.offAllNamed('/home'); // Replace with your home route
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');

      // Handle specific error codes
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email address";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address";
          break;
        case 'user-disabled':
          errorMessage = "This account has been disabled";
          break;
        case 'too-many-requests':
          errorMessage = "Too many failed attempts. Please try again later";
          break;
        default:
          errorMessage = e.message ?? "Login failed";
      }

      showAppSnackBar(errorMessage);
    } catch (e) {
      debugPrint('Login Error: $e');
      showAppSnackBar("Something went wrong. Please try again");
    } finally {
      _isLoading.value = false;
    }
  }

  /// Register new user
  Future<void> registerWithEmail(BuildContext context) async {
    if (!_validateInputs()) return;

    _isLoading.value = true;

    try {
      final email = emailCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) throw Exception("Account creation failed");

      // Create user document in Firestore (WITHOUT password!)
      await _firestore.collection('users').doc(user.uid).set({
        'email': email,
        'phone': null,
        'name': null,
        'defaultAddressId': null,
        'addresses': <String, dynamic>{},
        'cartItems': <String, dynamic>{},
        'favourites': <String>[],
        'wallet': {'points': 1000},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Optional: Send email verification
      // await user.sendEmailVerification();

      showAppSnackBar("Account created successfully!");
      clearFields();

      // Better navigation handling
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Get.offAllNamed('/home'); // Replace with your home route
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');

      // Handle specific error codes
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "An account with this email already exists";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password accounts are not enabled";
          break;
        case 'weak-password':
          errorMessage = "Password is too weak";
          break;
        default:
          errorMessage = e.message ?? "Sign up failed";
      }

      showAppSnackBar(errorMessage);
    } catch (e) {
      debugPrint('Registration Error: $e');
      showAppSnackBar("Something went wrong. Please try again");
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      clearFields();
      Get.offAllNamed('/login'); // Replace with your login route
    } catch (e) {
      debugPrint('Sign out error: $e');
      showAppSnackBar("Failed to sign out");
    }
  }

  /// Check if user is currently signed in
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
