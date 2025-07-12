import 'package:clothing/shared/common_wrapper.dart';
import 'package:clothing/shared/firebase.dart';
import 'package:clothing/shared/router.dart';
import 'package:clothing/views/auth/login_page.dart';
import 'package:clothing/views/auth/registartion_page.dart';
import 'package:clothing/views/home/data/dummyProduct.dart';
import 'package:clothing/views/home/widget/footer.dart';
import 'package:clothing/views/home/widget/how_it_work_section.dart';
import 'package:clothing/views/home/widget/impact_section.dart';
import 'package:clothing/views/home/widget/product_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF66BB8A),
      body: SafeArea(
        child:
            true
                ? CommonWrapper(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const NavBar(),
                        HeroSection(isMobile: isMobile),
                        FeaturedItemsSection(products: dummyProducts),

                        HowReWearWorksSection(),
                        const ImpactSection(),
                        // const Footer(),
                      ],
                    ),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const NavBar(),
                      HeroSection(isMobile: isMobile),
                      FeaturedItemsSection(products: dummyProducts),

                      HowReWearWorksSection(),
                      const ImpactSection(),
                      const Footer(),
                    ],
                  ),
                ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF66BB8A),
      height: 600,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Text(
                    "Give Your Clothes\nA Second Life",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Join the sustainable fashion revolution. Swap, redeem, and\n"
                    "discover amazing pre-loved clothes while earning points for every contribution.",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _ActionButton(text: 'Start Swapping', onPressed: () {}),
                      _ActionButton(
                        text: 'Browse Items',
                        disabled: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 48,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: const [
                      _FeatureIcon(
                        icon: Icons.loop,
                        title: 'Sustainable',
                        subtitle:
                            'Reduce fashion waste by giving\nclothes new homes',
                      ),
                      _FeatureIcon(
                        icon: Icons.groups,
                        title: 'Community',
                        subtitle:
                            'Connect with like-minded fashion\nenthusiasts',
                      ),
                      _FeatureIcon(
                        icon: Icons.emoji_events,
                        title: 'Rewarding',
                        subtitle:
                            'Earn points for every item you list\nand swap',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.recycling, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "ReWear",
            style: TextStyle(
              color: Colors.green.shade800,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 500),
          TextButton(
            onPressed: () {},
            child: Text(
              "Browse Items",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          SizedBox(width: 50),
          TextButton(
            onPressed: () {},
            child: Text(
              "How It Works",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          SizedBox(width: 50),
          TextButton(
            onPressed: () {},
            child: Text(
              "Community",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          Spacer(),
          const SizedBox(width: 16),
          const Icon(Icons.search),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text("1,250 pts"),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () {
              loginDialog(context);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade100,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text(
              "List Item",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    );
  }

  Future<dynamic> loginDialog(BuildContext context) {
    bool forLogin = true;
    return showDialog(
      context: context,
      builder: (context) {
        final _emailCtrl = TextEditingController();
        final _passCtrl = TextEditingController();
        final _cnfpassCtrl = TextEditingController();

        final _namectrl = TextEditingController();

        final _phoneCtrl = TextEditingController();

        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState2) {
            return Dialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(maxHeight: 800, maxWidth: 500),
                child:
                    forLogin
                        ? Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(32),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 420),
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Welcome Back 👋',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1B4332),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Log in to continue',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 24),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _namectrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _passCtrl,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState2(() => isLoading = true);
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                              email: _emailCtrl.text.trim(),
                                              password: _passCtrl.text.trim(),
                                            );
                                        Navigator.of(context).pop();
                                      } on FirebaseAuthException catch (e) {
                                        showError(
                                          context,
                                          e.message ?? "Login failed",
                                        );
                                      } finally {
                                        setState2(() => isLoading = false);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2C6E49),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Center(child: Text("or")),
                                  const SizedBox(height: 16),
                                  OutlinedButton.icon(
                                    onPressed: () async {
                                      try {
                                        final googleUser =
                                            await GoogleSignIn.instance
                                                .authenticate();
                                        final googleAuth =
                                            await googleUser.authentication;

                                        if (googleAuth != null) {
                                          final credential =
                                              GoogleAuthProvider.credential(
                                                idToken: googleAuth.idToken,
                                              );
                                          await FirebaseAuth.instance
                                              .signInWithCredential(credential);
                                        }
                                      } catch (e) {
                                        showError(
                                          context,
                                          "Google Sign-In failed",
                                        );
                                      }
                                    },
                                    icon: Image.asset(
                                      'assets/google_icon.png',
                                      height: 20,
                                    ),
                                    label: const Text("Continue with Google"),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () {
                                      forLogin = false;
                                      setState2(() {});
                                    },
                                    child: const Text(
                                      "Don’t have an account? Register",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        : Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(32),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 420),
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Create Account 🎉',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1B4332),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Join ReWear and make impact',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 24),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _namectrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _phoneCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Phone',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  TextField(
                                    controller: _emailCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _passCtrl,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _cnfpassCtrl,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_cnfpassCtrl.text.toLowerCase() !=
                                          _passCtrl.text.toLowerCase()) {
                                        showError(
                                          context,
                                          "Password does not match",
                                        );
                                        return;
                                      }
                                      setState2(() => isLoading = true);
                                      try {
                                        final res = await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                              email: _emailCtrl.text.trim(),
                                              password: _passCtrl.text.trim(),
                                            );
                                        if (res.user != null) {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(res.user!.uid)
                                              .set({
                                                'uid': res.user!.uid,
                                                'name': _namectrl.text.trim(),
                                                'email': _emailCtrl.text.trim(),
                                                'phone': _phoneCtrl.text.trim(),
                                                'address': '',
                                                'balance': 1000,
                                                'isAdmin': false,
                                              });
                                          Navigator.of(context).pop();
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        showError(
                                          context,
                                          e.message ?? "Registration failed",
                                        );
                                      } finally {
                                        setState2(() => isLoading = false);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2C6E49),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                    child: Text(
                                      'Register',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Center(child: Text("or")),
                                  const SizedBox(height: 16),
                                  OutlinedButton.icon(
                                    onPressed:
                                        isLoading
                                            ? null
                                            : () async {
                                              try {
                                                final googleUser =
                                                    await GoogleSignIn.instance
                                                        .authenticate();
                                                final googleAuth =
                                                    await googleUser
                                                        ?.authentication;

                                                if (googleAuth != null) {
                                                  final credential =
                                                      GoogleAuthProvider.credential(
                                                        idToken:
                                                            googleAuth.idToken,
                                                        accessToken:
                                                            googleAuth.idToken,
                                                      );
                                                  await FirebaseAuth.instance
                                                      .signInWithCredential(
                                                        credential,
                                                      );
                                                }
                                              } catch (e) {
                                                showError(
                                                  context,
                                                  "Google Sign-In failed",
                                                );
                                              }
                                            },
                                    icon: Image.asset(
                                      'assets/google_icon.png',
                                      height: 20,
                                    ),
                                    label: const Text("Continue with Google"),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      "Already have an account? Login",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: disabled ? Colors.white54 : Colors.white,
        foregroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_right_alt),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureIcon({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.green.shade700, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
}
