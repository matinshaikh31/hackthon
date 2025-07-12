import 'package:clothing/controller/auth_ctrl.dart';
import 'package:clothing/shared/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class AnimatedButtonWid extends StatelessWidget {
  const AnimatedButtonWid({
    super.key,
    required this.text,
    required this.width,
    this.onTap,
  });
  final String text;
  final double width;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPress: onTap,

      text: text,
      // width: 120,
      width: width,
      selectedTextColor: Colors.black,
      animationDuration: const Duration(milliseconds: 500),
      animatedOn: AnimatedOn.onHover,
      backgroundColor: darkborderColor,
      selectedBackgroundColor: const Color(0xfff3b6a5),
      borderColor: darkborderColor,
      borderWidth: .3,
      transitionType: TransitionType.LEFT_TO_RIGHT,

      textStyle: GoogleFonts.livvic(
        letterSpacing: 1,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

Future<dynamic> loginDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState2) {
          return Dialog(
            shape: const RoundedRectangleBorder(),
            child: GetBuilder<AuthCtrl>(
              builder: (authCtrl) {
                return ResponsiveWid(
                  mobile: Container(
                    decoration: const BoxDecoration(color: Color(0xfffef7f5)),
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                      maxHeight: 700,
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 350,
                                ),
                                child: Image.asset(
                                  "assets/images/login_side.png",
                                  fit: BoxFit.cover,
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    loginText(),
                                    const SizedBox(height: 20),

                                    // Email Field
                                    _buildEmailField(authCtrl),
                                    const SizedBox(height: 15),

                                    // Password Field
                                    _buildPasswordField(authCtrl, setState2),
                                    const SizedBox(height: 25),

                                    // Login Button
                                    _buildLoginButton(authCtrl, context),
                                    const SizedBox(height: 15),

                                    // Register Link
                                    _buildRegisterLink(authCtrl, context),
                                    const SizedBox(height: 12),

                                    _orDivider(),
                                    const SizedBox(height: 12),
                                    _otherLoginMethods(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          closeButton(true, authCtrl, context),
                        ],
                      ),
                    ),
                  ),

                  // DESKTOP
                  desktop: Container(
                    decoration: const BoxDecoration(color: Color(0xfffef7f5)),
                    constraints: const BoxConstraints(
                      maxWidth: 1000,
                      maxHeight: 550,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                "assets/images/login_side.png",
                                fit: BoxFit.cover,
                                height: double.maxFinite,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 70,
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        loginText(),
                                        const SizedBox(height: 20),

                                        // Email Field
                                        _buildEmailField(authCtrl),
                                        const SizedBox(height: 15),

                                        // Password Field
                                        _buildPasswordField(
                                          authCtrl,
                                          setState2,
                                        ),
                                        const SizedBox(height: 25),

                                        // Login Button
                                        _buildLoginButton(authCtrl, context),
                                        const SizedBox(height: 15),

                                        // Register Link
                                        _buildRegisterLink(authCtrl, context),
                                        const SizedBox(height: 12),

                                        _orDivider(),
                                        const SizedBox(height: 12),
                                        _otherLoginMethods(context),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        closeButton(false, authCtrl, context),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}

Widget _buildEmailField(AuthCtrl authCtrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Email",
        style: GoogleFonts.mulish(fontSize: 13, color: const Color(0xff4F4F4F)),
      ),
      const SizedBox(height: 7),
      SizedBox(
        height: 40,
        child: TextFormField(
          controller: authCtrl.emailCtrl,
          cursorHeight: 18,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: "Enter your email",
            hintStyle: GoogleFonts.mulish(
              fontSize: 14,
              color: const Color(0xff828282),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildPasswordField(AuthCtrl authCtrl, StateSetter setState2) {
  bool obscurePassword = true;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Password",
        style: GoogleFonts.mulish(fontSize: 13, color: const Color(0xff4F4F4F)),
      ),
      const SizedBox(height: 7),
      SizedBox(
        height: 40,
        child: StatefulBuilder(
          builder: (context, setPasswordState) {
            return TextFormField(
              controller: authCtrl.passwordCtrl,
              cursorHeight: 18,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: "Enter your password",
                hintStyle: GoogleFonts.mulish(
                  fontSize: 14,
                  color: const Color(0xff828282),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    size: 18,
                    color: const Color(0xff828282),
                  ),
                  onPressed: () {
                    obscurePassword = !obscurePassword;
                    setPasswordState(() {});
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildLoginButton(AuthCtrl authCtrl, BuildContext context) {
  return authCtrl.isLoading
      ? const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: themeColor, strokeWidth: 3.5),
        ),
      )
      : SizedBox(
        height: 40,
        child: AnimatedButtonWid(
          onTap: () async {
            await authCtrl.loginWithEmail(context);
          },
          text: 'Login',
          width: double.maxFinite,
        ),
      );
}

Widget _buildRegisterLink(AuthCtrl authCtrl, BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: GoogleFonts.mulish(
            fontSize: 13,
            color: const Color(0xff828282),
          ),
        ),
        GestureDetector(
          onTap: () {
            _showRegisterDialog(context);
          },
          child: Text(
            "Register",
            style: GoogleFonts.mulish(
              fontSize: 13,
              color: themeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

void _showRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState2) {
          return Dialog(
            shape: const RoundedRectangleBorder(),
            child: GetBuilder<AuthCtrl>(
              builder: (authCtrl) {
                return Container(
                  decoration: const BoxDecoration(color: Color(0xfffef7f5)),
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    maxHeight: 600,
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Create Account",
                                style: GoogleFonts.zcoolXiaoWei(
                                  letterSpacing: 1,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1C1C1C),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Email Field
                              _buildEmailField(authCtrl),
                              const SizedBox(height: 15),

                              // Password Field
                              _buildPasswordField(authCtrl, setState2),
                              const SizedBox(height: 25),

                              // Register Button
                              authCtrl.isLoading
                                  ? const Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: themeColor,
                                        strokeWidth: 3.5,
                                      ),
                                    ),
                                  )
                                  : SizedBox(
                                    height: 40,
                                    child: AnimatedButtonWid(
                                      onTap: () async {
                                        await authCtrl.registerWithEmail(
                                          context,
                                        );
                                      },
                                      text: 'Create Account',
                                      width: double.maxFinite,
                                    ),
                                  ),
                              const SizedBox(height: 15),

                              // Login Link
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: GoogleFonts.mulish(
                                        fontSize: 13,
                                        color: const Color(0xff828282),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.mulish(
                                          fontSize: 13,
                                          color: themeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: closeButton(true, authCtrl, context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}

Padding closeButton(bool isMobile, AuthCtrl authCtrl, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          authCtrl.clearFields();
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isMobile ? Colors.white : Colors.transparent,
            boxShadow:
                isMobile
                    ? [
                      const BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ]
                    : null,
          ),
          child: const Icon(
            CupertinoIcons.xmark,
            color: Color(0xff747474),
            size: 18,
          ),
        ),
      ),
    ),
  );
}

Row _orDivider() {
  return Row(
    children: [
      const Expanded(child: Divider(color: Color(0xffE0E0E0), height: 0)),
      const SizedBox(width: 15),
      Text(
        "or",
        style: GoogleFonts.leagueSpartan(
          fontSize: 16,
          color: const Color(0xff5B5B5B),
        ),
      ),
      const SizedBox(width: 15),
      const Expanded(child: Divider(color: Color(0xffE0E0E0), height: 0)),
    ],
  );
}

Text loginText() {
  return Text(
    "Login",
    style: GoogleFonts.zcoolXiaoWei(
      letterSpacing: 1,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: const Color(0xff1C1C1C),
    ),
  );
}

Widget _otherLoginMethods(BuildContext context) {
  // Add your other login methods here (Google, Facebook, etc.)
  // This is a placeholder - implement based on your needs
  return const SizedBox.shrink();
}
