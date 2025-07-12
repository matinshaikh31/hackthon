import 'package:flutter/material.dart';
// const themeColor = Color.fromARGB(255, 254, 237, 245);

// const themeColor = Color.fromARGB(255, 246, 230, 238);
// const themeColor = Color(0xffffbd9ce);

// const themeColor = Color.fromARGB(255, 246, 213, 229);
// const themeColor = Color(0xffffd2d2);
// const themeColor = Color(0xfff1d3d3);
// const themeColor = Color.fromARGB(255, 228, 180, 185);
const themeColorLite = Color(0xfffcedec);
// const themeColorLite = Color.fromARGB(255, 239, 205, 206);
// const themeColor = Color.fromARGB(255, 238, 197, 202);
// const themeColor = Color(0xffe5b4ba);
const themeColor = Color(0xffe5b4ba);

final themeData = ThemeData(
  colorSchemeSeed: themeColor,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  radioTheme: const RadioThemeData(
    fillColor: WidgetStatePropertyAll(Colors.black),
  ),
  bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.white),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
);

const darkborderColor = Color(0xffd88f77);

const dashboardSelectedColor = Color.fromARGB(255, 255, 209, 196);
