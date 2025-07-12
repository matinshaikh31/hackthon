import 'dart:ui';

import 'package:clothing/controller/auth_ctrl.dart';
import 'package:clothing/controller/mainController.dart';
import 'package:clothing/firebase_options.dart';
import 'package:clothing/shared/router.dart';
import 'package:clothing/shared/theme.dart';
import 'package:clothing/views/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  Get.put(AuthCtrl());
  Get.put(MainController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print(countryCodeFlagsList.map((e) => e['flag']));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ReWear',
      routerConfig: appRouter,
      theme: themeData,
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
    PointerDeviceKind.trackpad,
  };
}
