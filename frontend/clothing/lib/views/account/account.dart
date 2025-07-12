import 'package:clothing/shared/common_wrapper.dart';
import 'package:clothing/shared/firebase.dart';
import 'package:clothing/shared/router.dart';
import 'package:clothing/views/account/methods.dart';
import 'package:clothing/views/account/widgets/detail.dart';
import 'package:clothing/views/account/widgets/purchaseHistortTab.dart';
import 'package:clothing/views/account/widgets/swapRequestTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../const/const.dart';
import '../../shared/responsive.dart';
import '../../shared/methods.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobileScreen = screenWidth < desktopMinSize;

    return CommonWrapper(
      // backgroundColor: const Color(0xfffbfbfb),
      child: ResponsiveWid(
        mobile:
            isLoggedIn()
                ? _buildMobileTabs()
                : Center(
                  child: AnimatedButtonWid(
                    text: 'Login',
                    width: 120,
                    onTap: () async {
                      await loginDialog(context);
                      setState(() {});
                    },
                  ),
                ),
        desktop:
            isLoggedIn()
                ? _buildDesktopTabs(context)
                : Center(
                  child: AnimatedButtonWid(
                    text: 'Login',
                    width: 120,
                    onTap: () async {
                      await loginDialog(context);
                      setState(() {});
                    },
                  ),
                ),
      ),
    );
  }

  Widget _buildMobileTabs() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            // indicatorColor: primaryColor,
            tabs: const [
              Tab(text: 'Account Details'),
              Tab(text: 'Swap Requests'),
              Tab(text: 'Purchased & Swapped'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AccountDetailsTab(),
                SwapRequestsTab(),
                PurchaseHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTabs(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          constraints: BoxConstraints(
            maxWidth: 1300,
            minHeight: screenHeight - getExtraHeight(isMobile: false),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sidebar
              Container(
                padding: const EdgeInsets.all(17),
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffE1E1E1)),
                ),
                child: Column(
                  children: [
                    _buildSidebarTile("Account Details", 0),
                    _buildSidebarTile("Swap Requests", 1),
                    _buildSidebarTile("Purchased & Swapped", 2),
                    const SizedBox(height: 20),
                    _buildLogoutTile(context),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    AccountDetailsTab(),
                    SwapRequestsTab(),
                    PurchaseHistoryTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarTile(String title, int index) {
    final selected = tabController.index == index;
    return InkWell(
      onTap: () {
        tabController.animateTo(index);
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selected ? const Color(0xffFFCBBA) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              _getIconForTitle(title),
              color: const Color(0xFF6C6C6C),
              size: 21,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.mulish(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3E3E3E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Account Details':
        return CupertinoIcons.profile_circled;
      case 'Swap Requests':
        return CupertinoIcons.arrow_2_circlepath;
      case 'Purchased & Swapped':
        return Icons.shopping_bag_outlined;
      default:
        return Icons.circle;
    }
  }

  Widget _buildLogoutTile(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool res = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await FBAuth.auth.signOut();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        if (res) {
          context.go(Routes.home);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.square_arrow_right,
              color: Color(0xFF6C6C6C),
              size: 21,
            ),
            const SizedBox(width: 10),
            Text(
              'Logout',
              style: GoogleFonts.mulish(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3E3E3E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
