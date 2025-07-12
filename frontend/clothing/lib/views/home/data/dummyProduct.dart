import 'package:clothing/models/productModel.dart';

final dummyProducts = [
  ProductModel(
    productId: '1',
    ownerId: 'user1',
    title: 'Vintage Denim Jacket',
    description: 'Levi\'s • Size M',
    imageUrl: '', // leave empty for now
    category: 'Vintage',
    tags: ['Vintage', 'Denim', 'Excellent'],
    price: 450,
  ),
  ProductModel(
    productId: '2',
    ownerId: 'user2',
    title: 'Floral Summer Dress',
    description: 'Zara • Size S',
    imageUrl: '',
    category: 'Summer',
    tags: ['Summer', 'Floral', 'Like New'],
    price: 320,
  ),
  ProductModel(
    productId: '3',
    ownerId: 'user3',
    title: 'Wool Blend Coat',
    description: 'H&M • Size L',
    imageUrl: '',
    category: 'Winter',
    tags: ['Winter', 'Wool', 'Good'],
    price: 280,
  ),
  ProductModel(
    productId: '4',
    ownerId: 'user4',
    title: 'Silk Blouse',
    description: 'Uniqlo • Size M',
    imageUrl: '',
    category: 'Silk',
    tags: ['Silk', 'Business', 'Excellent'],
    price: 380,
  ),
];
