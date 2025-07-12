import 'package:clothing/models/productModel.dart';
import 'package:clothing/models/purchaseModel.dart';
import 'package:clothing/models/settiingsModel.dart';
import 'package:clothing/models/swapRequestModel.dart';
import 'package:clothing/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<UserModel> users = [];
  List<ProductModel> products = [];
  List<SwapRequestModel> swapRequests = [];
  SettingModel? settings;

  // Logged-in user data
  UserModel? currentUser;
  List<PurchaseModel> userPurchases = [];
  List<SwapRequestModel> userSwaps = [];

  @override
  void onInit() {
    super.onInit();
    listenToUsers();
    listenToProducts();
    listenToSwapRequests();
    listenToSettings();
    listenToAuthChanges();
  }

  void listenToUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      users =
          snapshot.docs
              .map((doc) => UserModel.fromSnapshot(doc.data()))
              .toList();
      update();
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

  void listenToAuthChanges() {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        // User is logged in
        await fetchCurrentUser(user.uid);
        await fetchUserPurchases(user.uid);
        await fetchUserSwaps(user.uid);
      } else {
        // User logged out — clear local data
        currentUser = null;
        userPurchases.clear();
        userSwaps.clear();
        update();
      }
    });
  }

  Future<void> fetchCurrentUser(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      currentUser = UserModel.fromSnapshot(userDoc.data()!);
    }
    update();
  }

  Future<void> fetchUserPurchases(String uid) async {
    final snapshot =
        await _firestore
            .collection('purchases')
            .where('buyerId', isEqualTo: uid)
            .orderBy('purchasedAt', descending: true)
            .get();

    userPurchases =
        snapshot.docs
            .map((doc) => PurchaseModel.fromSnapshot(doc.data()))
            .toList();
    update();
  }

  Future<void> fetchUserSwaps(String uid) async {
    final snapshot =
        await _firestore
            .collection('swap_requests')
            .where('requesterId', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .get();

    userSwaps =
        snapshot.docs
            .map((doc) => SwapRequestModel.fromSnapshot(doc.data()))
            .toList();
    update();
  }
}
