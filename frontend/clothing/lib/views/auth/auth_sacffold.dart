import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onSubmit;
  final VoidCallback onGoogle;
  final bool isLoading;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController? namaCtrl;
  final TextEditingController? cnfPassCtrl;

  final TextEditingController? phonectrl;

  final Widget footer;

  const AuthScaffold({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onSubmit,
    required this.onGoogle,
    required this.isLoading,
    required this.emailCtrl,
    required this.passCtrl,
    required this.footer,
    this.namaCtrl,
    this.cnfPassCtrl,
    this.phonectrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      body: Center(
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
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B4332),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 16),
                TextField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (buttonText != 'Login') ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: phonectrl,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                if (buttonText != 'Login') ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: cnfPassCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C6E49),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: Text("or")),
                const SizedBox(height: 16),
                // OutlinedButton.icon(
                //   onPressed: isLoading ? null : onGoogle,
                //   icon: Image.asset('assets/google_icon.png', height: 20),
                //   label: const Text("Continue with Google"),
                // ),
                const SizedBox(height: 12),
                footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
