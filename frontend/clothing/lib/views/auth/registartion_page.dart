import 'package:clothing/shared/firebase.dart';
import 'package:clothing/shared/router.dart';
import 'package:clothing/views/auth/auth_sacffold.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _cnfpassCtrl = TextEditingController();

  final _namectrl = TextEditingController();

  final _phoneCtrl = TextEditingController();

  bool isLoading = false;

  Future<void> _register() async {
    if (_cnfpassCtrl.text.toLowerCase() != _passCtrl.text.toLowerCase()) {
      _showError("Password does not match");
      return;
    }
    setState(() => isLoading = true);
    try {
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
      if (res.user != null) {
        await FBFireStore.users.doc(res.user!.uid).set({
          'uid': res.user!.uid,
          'name': _namectrl.text.trim(),
          'email': _emailCtrl.text.trim(),
          'phone': _phoneCtrl,
          'address': '',
          'balance': 1000,
          'isAdmin': false,
        });
        context.go(Routes.home);
      }
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
      cnfPassCtrl: _cnfpassCtrl,
      namaCtrl: _namectrl,
      phonectrl: _phoneCtrl,
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
