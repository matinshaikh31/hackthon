class PurchaseModel {
  final String purchaseId;
  final String buyerId;
  final String sellerId;
  final String productId;
  final int price;
  final DateTime purchasedAt;

  // New fields
  final String image;
  final String name;
  final String description;

  PurchaseModel({
    required this.purchaseId,
    required this.buyerId,
    required this.sellerId,
    required this.productId,
    required this.price,
    required this.purchasedAt,
    required this.image,
    required this.name,
    required this.description,
  });

  factory PurchaseModel.fromSnapshot(Map<String, dynamic> json) {
    return PurchaseModel(
      purchaseId: json['purchaseId'],
      buyerId: json['buyerId'],
      sellerId: json['sellerId'],
      productId: json['productId'],
      price: json['price'],
      purchasedAt: DateTime.parse(json['purchasedAt']),
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'purchaseId': purchaseId,
    'buyerId': buyerId,
    'sellerId': sellerId,
    'productId': productId,
    'price': price,
    'purchasedAt': purchasedAt.toIso8601String(),
    'image': image,
    'name': name,
    'description': description,
  };

  Map<String, dynamic> toJson() => toMap();
}
