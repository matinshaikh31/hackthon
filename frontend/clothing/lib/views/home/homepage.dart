import 'package:clothing/controller/mainController.dart';
import 'package:clothing/services/image_picker.dart';
import 'package:clothing/shared/common_wrapper.dart';
import 'package:clothing/shared/firebase.dart';
import 'package:clothing/shared/methods.dart';
import 'package:clothing/shared/router.dart';
import 'package:clothing/views/auth/login_page.dart';
import 'package:clothing/views/home/data/dummyProduct.dart';
import 'package:clothing/views/home/widget/footer.dart';
import 'package:clothing/views/home/widget/how_it_work_section.dart';
import 'package:clothing/views/home/widget/impact_section.dart';
import 'package:clothing/views/home/widget/product_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF66BB8A),
      body: SafeArea(
        child:
            true
                ? CommonWrapper(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const NavBar(),
                        HeroSection(isMobile: isMobile),
                        FeaturedItemsSection(products: dummyProducts),

                        HowReWearWorksSection(),
                        const ImpactSection(),
                        // const Footer(),
                      ],
                    ),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const NavBar(),
                      HeroSection(isMobile: isMobile),
                      FeaturedItemsSection(products: dummyProducts),

                      HowReWearWorksSection(),
                      const ImpactSection(),
                      const Footer(),
                    ],
                  ),
                ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF66BB8A),
      height: 600,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Text(
                    "Give Your Clothes\nA Second Life",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Join the sustainable fashion revolution. Swap, redeem, and\n"
                    "discover amazing pre-loved clothes while earning points for every contribution.",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _ActionButton(text: 'Start Swapping', onPressed: () {}),
                      _ActionButton(
                        text: 'Browse Items',
                        disabled: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 48,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: const [
                      _FeatureIcon(
                        icon: Icons.loop,
                        title: 'Sustainable',
                        subtitle:
                            'Reduce fashion waste by giving\nclothes new homes',
                      ),
                      _FeatureIcon(
                        icon: Icons.groups,
                        title: 'Community',
                        subtitle:
                            'Connect with like-minded fashion\nenthusiasts',
                      ),
                      _FeatureIcon(
                        icon: Icons.emoji_events,
                        title: 'Rewarding',
                        subtitle:
                            'Earn points for every item you list\nand swap',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.recycling, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "ReWear",
            style: TextStyle(
              color: Colors.green.shade800,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 500),
          TextButton(
            onPressed: () {},
            child: Text(
              "Browse Items",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          SizedBox(width: 50),
          TextButton(
            onPressed: () {},
            child: Text(
              "How It Works",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          SizedBox(width: 50),
          TextButton(
            onPressed: () {},
            child: Text(
              "Community",
              style: TextStyle(color: Colors.green.shade800),
            ),
          ),
          Spacer(),
          const SizedBox(width: 16),
          const Icon(Icons.search),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text("1,250 pts"),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: LoginPage());
                },
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade100,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  final pnameCtrl = TextEditingController();
                  final ppointsCtrl = TextEditingController();
                  final pdescCtrl = TextEditingController();
                  SelectedImage? pimageCtrl;
                  String? category;
                  bool forSwap = false;
                  bool isLoading = false;
                  List<String> tags = [];
                  return Dialog(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    child: StatefulBuilder(
                      builder: (context, setState2) {
                        return Container(
                          constraints: BoxConstraints(
                            maxWidth: 400,
                            maxHeight: 600,
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Product",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text("Product Name"),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: pnameCtrl,
                                  decoration: inpDecor().copyWith(
                                    hintText: 'Product Name',
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Product Points"),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: ppointsCtrl,
                                  decoration: inpDecor().copyWith(
                                    hintText: 'Product Points',
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Product Category"),
                                SizedBox(height: 3),
                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: inpDecor().copyWith(
                                      hintText: 'Select Category',
                                    ),
                                    value: category,
                                    items: [
                                      ...List.generate(
                                        Get.find<MainController>()
                                            .settings!
                                            .categories
                                            .length,
                                        (index) {
                                          return DropdownMenuItem(
                                            value:
                                                Get.find<MainController>()
                                                    .settings!
                                                    .categories[index],
                                            child: Text(
                                              Get.find<MainController>()
                                                  .settings!
                                                  .categories[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                    onChanged: (value) {
                                      category = value;
                                      setState2(() {});
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Product Description"),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: pdescCtrl,
                                  decoration: inpDecor().copyWith(
                                    hintText: 'Product Description',
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Swap"),
                                SizedBox(height: 3),
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),

                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: forSwap,
                                        onChanged: (value) {
                                          forSwap = value!;
                                          setState2(() {});
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Text("For Swap"),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10),
                                Text("Product Image"),
                                SizedBox(height: 3),
                                InkWell(
                                  onTap: () async {
                                    final image = await ImagePickerService()
                                        .pickImageNew(
                                          context,
                                          useCompressor: true,
                                        );
                                    setState2(() {
                                      pimageCtrl = image;
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        pimageCtrl != null
                                            ? Image.memory(
                                              pimageCtrl!.uInt8List,
                                              fit: BoxFit.cover,
                                            )
                                            : Center(
                                              child: Icon(
                                                CupertinoIcons.photo_camera,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                isLoading
                                    ? Center(
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.green.shade700,
                                            strokeWidth: 3.5,
                                          ),
                                        ),
                                      ),
                                    )
                                    : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade700,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        minimumSize: Size(double.maxFinite, 48),
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () async {
                                        if (pimageCtrl == null) {
                                          return;
                                        }
                                        setState2(() {
                                          isLoading = true;
                                        });
                                        final imageUrl =
                                            await uploadGalleryFiles(
                                              pimageCtrl!,
                                            );
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .add({
                                              'productId': '',
                                              'ownerId': '',
                                              'title': pnameCtrl.text,
                                              'description': pdescCtrl.text,
                                              'imageUrl': imageUrl,
                                              'category': category,
                                              'tags': tags,
                                              'price': num.tryParse(
                                                ppointsCtrl.text,
                                              ),
                                              'isAvailable': true,
                                              'forSwap': forSwap,
                                            });
                                        setState2(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text(
              "List Item",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: disabled ? Colors.white54 : Colors.white,
        foregroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_right_alt),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureIcon({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.green.shade700, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
