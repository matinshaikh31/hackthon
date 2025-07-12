class ProductModel {
  final String productId;
  final String ownerId;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final int price;
  final bool isAvailable;
  final bool forSwap;

  ProductModel({
    required this.productId,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.tags,
    required this.price,
    this.isAvailable = true,
    this.forSwap = false,
  });

  factory ProductModel.fromSnapshot(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      price: json['price'],
      isAvailable: json['isAvailable'] ?? true,
      forSwap: json['forSwap'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'productId': productId,
    'ownerId': ownerId,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'category': category,
    'tags': tags,
    'price': price,
    'isAvailable': isAvailable,
    'forSwap': forSwap,
  };

  Map<String, dynamic> toJson() => toMap();
}
