import 'package:flutter/material.dart';

const double mobileMinSize = 768;
const double desktopMinSize = 1024;
const mobileMinSize2 = mobileMinSize - 200;
const mobileMinSize3 = mobileMinSize + 200;
const desktopMinSize2 = desktopMinSize - 200;

const double appBarHeight = 150;
const double stickyBarHeight = 55;
const double desktopfooterMaxHeight = 600;
const double mobilefooterMaxHeight = 1200;
const double copyrightHeight = 40;
const chatLink = "https://wa.me/19084561408";
const callLink = "tel://19084561408";
const int perPageProducts = 15;

double getExtraHeight({required bool isMobile, bool allDisplay = true}) {
  // if (isMobile) {
  // } else {}
  return appBarHeight +
      // stickyBarHeight +
      // copyrightHeight +
      (allDisplay
          ? (isMobile ? mobilefooterMaxHeight : desktopfooterMaxHeight)
          : 0);
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
List<String> appbarTiles = ['HOME', 'OFFERINGS', 'GALLERY', 'PACKAGES'];
