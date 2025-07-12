import 'package:clothing/controller/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PurchaseHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (ctrl) {
        final purchases = ctrl.userPurchases;

        if (purchases.isEmpty) return const Text("No purchases yet");

        return ListView.builder(
          itemCount: purchases.length,
          itemBuilder: (context, index) {
            final purchase = purchases[index];
            return ListTile(
              leading: Image.network(purchase.image, width: 50),
              title: Text(purchase.name),
              subtitle: Text(
                "₹${purchase.price} • ${purchase.purchasedAt.toLocal()}",
              ),
            );
          },
        );
      },
    );
  }
}
