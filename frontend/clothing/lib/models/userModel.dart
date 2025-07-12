import 'package:clothing/models/walletModel.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final num balance;
  final bool isAdmin;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    required this.balance,
    this.isAdmin = false,
  });

  factory UserModel.fromSnapshot(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      balance: json['balance'],
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
    if (phone != null) 'phone': phone,
    if (address != null) 'address': address,
    'balance': balance,
    'isAdmin': isAdmin,
  };

  Map<String, dynamic> toJson() => toMap();
}
