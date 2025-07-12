import 'package:clothing/controller/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AccountDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (ctrl) {
        final user = ctrl.currentUser;
        if (user == null) return const Text("Not logged in");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name ?? 'N/A'}"),
            Text("Email: ${user.email}"),
            Text("Phone: ${user.phone ?? 'N/A'}"),
            Text("Wallet: ${user.balance ?? 0} points"),
            Text("Address: ${user.address ?? 'Not added'}"),
          ],
        );
      },
    );
  }
}
