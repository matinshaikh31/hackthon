class PurchaseModel {
  final String purchaseId;
  final String buyerId;
  final String sellerId;
  final String productId;
  final int price;
  final DateTime purchasedAt;

  PurchaseModel({
    required this.purchaseId,
    required this.buyerId,
    required this.sellerId,
    required this.productId,
    required this.price,
    required this.purchasedAt,
  });

  factory PurchaseModel.fromSnapshot(Map<String, dynamic> json) {
    return PurchaseModel(
      purchaseId: json['purchaseId'],
      buyerId: json['buyerId'],
      sellerId: json['sellerId'],
      productId: json['productId'],
      price: json['price'],
      purchasedAt: DateTime.parse(json['purchasedAt']),
    );
  }

  Map<String, dynamic> toMap() => {
    'purchaseId': purchaseId,
    'buyerId': buyerId,
    'sellerId': sellerId,
    'productId': productId,
    'price': price,
    'purchasedAt': purchasedAt.toIso8601String(),
  };

  Map<String, dynamic> toJson() => toMap();
}
