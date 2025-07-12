import 'package:clothing/views/auth/auth_sacffold.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool isLoading = false;

  Future<void> _register() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Registration failed");
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
          accessToken: googleAuth.idToken,
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
      title: 'Create Account 🎉',
      subtitle: 'Join ReWear and make impact',
      buttonText: 'Register',
      isLoading: isLoading,
      onSubmit: _register,
      onGoogle: _googleSignIn,
      emailCtrl: _emailCtrl,
      passCtrl: _passCtrl,
      footer: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Already have an account? Login"),
      ),
    );
  }
}
