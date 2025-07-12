import 'package:clothing/controller/auth_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Adjust import if needed

Future<void> loginDialog(BuildContext context) async {
  final authCtrl = Get.find<AuthCtrl>();

  return showDialog(
    context: context,
    builder:
        (_) => Dialog(
          backgroundColor: Colors.white,
          child: GetBuilder<AuthCtrl>(
            // This allows reactive isLoading
            builder: (ctrl) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: ctrl.emailCtrl,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ctrl.passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 20),
                    if (ctrl.isLoading)
                      const CircularProgressIndicator()
                    else
                      Column(
                        children: [
                          AnimatedButtonWid(
                            text: "Login",
                            onTap: () => ctrl.loginWithEmail(context),
                            width: 160,
                          ),
                          const SizedBox(height: 12),
                          AnimatedButtonWid(
                            text: "Create Account",
                            onTap: () => ctrl.registerWithEmail(context),
                            width: 160,
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
  );
}

class AnimatedButtonWid extends StatefulWidget {
  final String text;
  final double width;
  final VoidCallback onTap;
  final bool loading;
  final Color? color;
  final double height;
  final double borderRadius;

  const AnimatedButtonWid({
    super.key,
    required this.text,
    required this.onTap,
    this.width = 150,
    this.height = 48,
    this.color,
    this.loading = false,
    this.borderRadius = 10,
  });

  @override
  State<AnimatedButtonWid> createState() => _AnimatedButtonWidState();
}

class _AnimatedButtonWidState extends State<AnimatedButtonWid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.05,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => _controller.reverse(),
      onTap: widget.loading ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.color ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              alignment: Alignment.center,
              child:
                  widget.loading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                      : Text(
                        widget.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
