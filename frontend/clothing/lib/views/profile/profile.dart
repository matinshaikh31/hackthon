import 'package:clothing/models/productModel.dart';
import 'package:clothing/views/home/data/dummyProduct.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ReWear",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.green.shade100,
        child: const Text(
          '© 2025 ReWear. All rights reserved.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Alex Smith',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Sustainable Fashion Enthusiast'),
                    Text('📍 San Francisco, CA'),
                    Text('📅 Joined March 2024'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatsSection(),
            const SizedBox(height: 20),
            _buildAchievements(),
            const SizedBox(height: 20),
            const Text(
              'My Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children:
                  dummyProducts
                      .map((item) => ProductCard(product: item))
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.swap_horiz),
        title: const Text('Items Swapped'),
        subtitle: const Text('47'),
        trailing: const Text('Rating: 4.9 ⭐'),
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Achievements',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: Icon(Icons.verified),
          title: Text('First Swap'),
          subtitle: Text('Completed your first item swap'),
        ),
        ListTile(
          leading: Icon(Icons.eco),
          title: Text('Eco Warrior'),
          subtitle: Text('Saved 50+ items from waste'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Top Rated'),
          subtitle: Text('Maintained 4.5+ rating'),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          const Expanded(
            child:
                Placeholder(), // Replace with Image.network(product.imageUrl)
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Size M • ${product.tags.join(', ')}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children:
                      product.tags
                          .map(
                            (t) => Chip(
                              label: Text(t),
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                ),
                Text(
                  '${product.price} pts',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
