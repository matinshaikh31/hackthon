import 'package:clothing/views/home/homepage.dart';
import 'package:clothing/views/home/widget/footer.dart';
import 'package:flutter/material.dart';

class CommonWrapper extends StatelessWidget {
  final Widget child;

  const CommonWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF66BB8A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            Row(children: [Expanded(child: child)]),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
