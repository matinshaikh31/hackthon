import 'package:clothing/controller/auth_ctrl.dart';
import 'package:clothing/controller/mainController.dart';
import 'package:clothing/models/userModel.dart';
import 'package:clothing/shared/common_wrapper.dart';
import 'package:clothing/views/home/data/dummyProduct.dart';
import 'package:clothing/views/home/widget/product_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTab = 0;

  final List<String> tabs = ['My Closet', 'Activity', 'Requests', 'Reviews'];

  @override
  Widget build(BuildContext context) {
    return CommonWrapper(
      child: GetBuilder<MainController>(
        builder: (cntrl) {
          print(cntrl.currentUser);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 24),
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left Column
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        _profileCard(cntrl.currentUser),
                        const SizedBox(height: 16),
                        _statsCard(),
                        const SizedBox(height: 16),
                        _achievementsCard(),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  /// Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tabsHeader(),
                        const SizedBox(height: 16),
                        if (selectedTab == 0) ...[
                          _myItemsHeader(),
                          const SizedBox(height: 16),
                          _productsGrid(),
                        ] else
                          _tabPlaceholder(tabs[selectedTab]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tabsHeader() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xF5F3F0FF), // light grayish background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey[700],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _tabPlaceholder(String label) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          '$label section coming soon...',
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _myItemsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "My Items",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Add New Item")),
      ],
    );
  }

  Widget _productsGrid() {
    return MasonryGridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4, // or 3 for wider screens
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(dummyProducts[index]);
      },
    );
  }

  Widget _profileCard(UserModel? user) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
            const SizedBox(height: 8),
            Text(
              user?.name ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Sustainable Fashion Enthusiast'),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 14),
                SizedBox(width: 4),
                Text('San Francisco, CA', style: TextStyle(fontSize: 12)),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 14),
                SizedBox(width: 4),
                Text('Joined March 2024', style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Share Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text("Stats", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "47",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Items Swapped"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "4.9",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Rating"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, size: 14),
                SizedBox(width: 4),
                Text("1,250 Eco Points"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _achievementsCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Achievements", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _AchievementTile(
              icon: Icons.check_circle_outline,
              title: "First Swap",
              subtitle: "Completed your first item swap",
            ),
            _AchievementTile(
              icon: Icons.recycling,
              title: "Eco Warrior",
              subtitle: "Saved 50+ items from waste",
            ),
            _AchievementTile(
              icon: Icons.star_border,
              title: "Top Rated",
              subtitle: "Maintained 4.5+ rating",
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AchievementTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 20),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    );
  }
}
