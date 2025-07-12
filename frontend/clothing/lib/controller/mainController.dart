import 'package:clothing/models/productModel.dart';
import 'package:clothing/models/settiingsModel.dart';
import 'package:clothing/models/swapRequestModel.dart';
import 'package:clothing/models/userModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> users = [];
  List<ProductModel> products = [];
  List<SwapRequestModel> swapRequests = [];
  SettingModel? settings;

  @override
  void onInit() {
    super.onInit();
    listenToUsers();
    listenToProducts();
    listenToSwapRequests();
    listenToSettings();
  }

  void listenToUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      users =
          snapshot.docs
              .map((doc) => UserModel.fromSnapshot(doc.data()))
              .toList();
      update(); // Notify UI
    });
  }

  void listenToProducts() {
    _firestore.collection('products').snapshots().listen((snapshot) {
      products =
          snapshot.docs
              .map((doc) => ProductModel.fromSnapshot(doc.data()))
              .toList();
      update();
    });
  }

  void listenToSwapRequests() {
    _firestore.collection('swap_requests').snapshots().listen((snapshot) {
      swapRequests =
          snapshot.docs
              .map((doc) => SwapRequestModel.fromSnapshot(doc.data()))
              .toList();
      update();
    });
  }

  void listenToSettings() {
    _firestore.collection('settings').limit(1).snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        settings = SettingModel.fromSnapshot(snapshot.docs.first.data());
        update();
      }
    });
  }
}
