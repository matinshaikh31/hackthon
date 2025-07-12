import 'package:clothing/views/auth/auth_sacffold.dart';
import 'package:clothing/views/auth/registartion_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Login failed");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      _showError("Google Sign-In failed");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome Back 👋',
      subtitle: 'Log in to continue',
      buttonText: 'Login',
      isLoading: isLoading,
      onSubmit: _login,
      onGoogle: _googleSignIn,
      emailCtrl: _emailCtrl,
      passCtrl: _passCtrl,
      footer: TextButton(
        onPressed: () {},
        child: const Text("Don’t have an account? Register"),
      ),
    );
  }
}
