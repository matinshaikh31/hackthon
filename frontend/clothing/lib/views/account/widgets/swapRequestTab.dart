import 'package:clothing/controller/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SwapRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (ctrl) {
        final swaps = ctrl.userSwaps;

        if (swaps.isEmpty) return const Text("No swap requests found");

        return ListView.builder(
          itemCount: swaps.length,
          itemBuilder: (context, index) {
            final swap = swaps[index];
            return ListTile(
              title: Text("Requested to swap with ${swap.toUserId}"),
              subtitle: Text("Created: ${swap.createdAt.toLocal()}"),
            );
          },
        );
      },
    );
  }
}
