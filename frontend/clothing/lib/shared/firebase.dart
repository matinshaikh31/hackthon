import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FBAuth {
  static final auth = FirebaseAuth.instance;
}

class FBFireStore {
  static final fb = FirebaseFirestore.instance;
  // static final sets = fb.collection('sets').doc('sets');
  static final users = fb.collection('users');
  static final product = fb.collection('product');
  static final weightrange = fb.collection('weightrange');
  static final flavour = fb.collection('flavour');
  static final designcost = fb.collection('designcost');
  static final order = fb.collection('order');
  // static final userdetail = fb.collection('userdetail');
  static final mainCategory = fb.collection('mainCategory');
  static final categorySet = fb.collection('categorySet');
  static final setting = fb.collection('settings').doc('sets');
  static final orderProduct = fb.collection('orderProduct');
  // static final delCharges = fb.collection('delCharges');
}

class FBStorage {
  static final fbstore = FirebaseStorage.instance;
  static final category = fbstore.ref().child('category');
  static final food = fbstore.ref().child('food');
  static final images = fbstore.ref().child('images');
  // static final otherCertis = fb.ref().child('otherCertis');
}

// class FBFunctions {
//   static final ff = FirebaseFunctions.instance;
// }
