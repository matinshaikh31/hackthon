import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'firebase.dart';

bool isLoggedIn() => FBAuth.auth.currentUser != null;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomId(int length) => String.fromCharCodes(
  Iterable.generate(
    length,
    (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
  ),
);

String formatDate(DateTime date) {
  // Extract year, month, and day from the DateTime object
  String year = date.year.toString();
  String month = date.month.toString().padLeft(
    2,
    '0',
  ); // Ensure two digits for month
  String day = date.day.toString().padLeft(2, '0'); // Ensure two digits for day

  // Concatenate the formatted components with "-"
  return '$day-$month-$year';
}

String deldatefromat(DateTime date) {
  // Extract year, month, and day from the DateTime object
  String year = date.year.toString();
  String month = date.month.toString().padLeft(
    2,
    '0',
  ); // Ensure two digits for month
  String day = date.day.toString().padLeft(2, '0'); // Ensure two digits for day

  // Concatenate the formatted components with "-"
  return '$year-$month-$day';
}

showAppSnack(
  String message, {
  SNACKBARTYPE snackbartype = SNACKBARTYPE.normal,
  Duration? duration,
}) {
  try {
    return;
  } catch (e) {
    debugPrint(e.toString());
  }
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
showAppSnackBar(
  String message, {
  SnackBarAction? action,
  Duration duration = const Duration(milliseconds: 1500),
}) => snackbarKey.currentState?.showSnackBar(
  SnackBar(
    content: Text(message, style: TextStyle(color: Colors.white)),
    action: action,
    duration: duration,
  ),
);

enum SNACKBARTYPE { normal, success, error, warning }

extension MetaWid on DateTime {
  String goodDate() {
    try {
      return DateFormat.yMMMM().format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }

  String goodDayDate() {
    try {
      return DateFormat.yMMMMd().format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }

  String goodTime() {
    try {
      return DateFormat('hh:mm a').format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }
}

InputDecoration textfieldDecoration() {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 200, 81, 72)),
    ),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

Future<dynamic> showDragableSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    // showDragHandle: true,
    backgroundColor: Colors.grey[200],
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: child,
            );
          },
        ),
  );
}

InputDecoration textFieldDecoration() {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

InputDecoration settingsTextFieldDecoration() {
  return InputDecoration(
    fillColor: Colors.grey.shade100,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(6),
    ),
  );
}
