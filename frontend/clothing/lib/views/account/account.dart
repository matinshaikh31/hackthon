import 'package:clothing/const/const.dart';
import 'package:clothing/controller/auth_ctrl.dart';
import 'package:clothing/controller/mainController.dart';
import 'package:clothing/shared/common_wrapper.dart';
import 'package:clothing/shared/methods.dart';
import 'package:clothing/shared/responsive.dart';
import 'package:clothing/views/account/methods.dart';

import 'package:clothing/models/purchaseModel.dart';
import 'package:clothing/models/swapRequestModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../shared/router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  final AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final MainController mainCtrl = Get.find<MainController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return CommonWrapper(
      child: ResponsiveWid(
        mobile: _buildMobileLayout(),
        desktop: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              constraints: BoxConstraints(
                maxWidth: 1300,
                minHeight:
                    screenHeight -
                                getExtraHeight(
                                  isMobile: screenWidth < desktopMinSize,
                                ) <=
                            0
                        ? 0
                        : screenHeight -
                            getExtraHeight(
                              isMobile: screenWidth < desktopMinSize,
                            ),
              ),
              child: _buildDesktopLayout(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return StreamBuilder(
      stream: authCtrl.authStateChanges,
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.hasData && snapshot.data != null;

        if (!isLoggedIn) {
          return _buildLoginPrompt();
        }

        return Column(
          children: [
            _buildUserAccountDetails(),
            const SizedBox(height: 30),
            Expanded(child: _buildOrderTabs()),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return StreamBuilder(
      stream: authCtrl.authStateChanges,
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.hasData && snapshot.data != null;

        if (!isLoggedIn) {
          return _buildLoginPrompt();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildUserAccountDetails(),
            ),
            Expanded(child: _buildOrderTabs()),
          ],
        );
      },
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.person_circle,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Please login to access your account',
            style: GoogleFonts.mulish(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Obx(
            () => AnimatedButtonWid(
              text: authCtrl.isLoading ? 'Loading...' : 'Login',
              width: 200,
              onTap:
                  authCtrl.isLoading
                      ? null
                      : () async {
                        await loginDialog(context);
                      },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAccountDetails() {
    return GetBuilder<MainController>(
      builder: (controller) {
        final user = controller.currentUser;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xffE1E1E1)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xffFFCBBA),
                    child: Text(
                      user?.name?.substring(0, 1).toUpperCase() ??
                          user?.email?.substring(0, 1).toUpperCase() ??
                          'U',
                      style: GoogleFonts.mulish(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'User Account',
                          style: GoogleFonts.mulish(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff3E3E3E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? '',
                          style: GoogleFonts.mulish(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (user?.phone != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            user!.phone!,
                            style: GoogleFonts.mulish(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Active',
                                style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Wallet: ${user?.wallet.points ?? 0} pts',
                                style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed:
                          authCtrl.isLoading ? null : () => _showLogoutDialog(),
                      icon: Icon(
                        CupertinoIcons.square_arrow_right,
                        color: authCtrl.isLoading ? Colors.grey : Colors.red,
                      ),
                      tooltip: 'Logout',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildAccountStats(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountStats(MainController controller) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Purchases',
            controller.userPurchases.length.toString(),
            CupertinoIcons.bag,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Swap Requests',
            controller.userSwaps.length.toString(),
            CupertinoIcons.arrow_2_circlepath,
            Colors.green,
          ),
        ),
        // const SizedBox(width: 16),
        // Expanded(
        //   child: _buildStatCard(
        //     'Favourites',
        //     controller.currentUser?.favourites?.length.toString() ?? '0',
        //     CupertinoIcons.heart,
        //     Colors.red,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.mulish(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.mulish(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE1E1E1)),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Purchase Orders'),
              Tab(text: 'Swap Orders'),
            ],
            indicatorColor: const Color(0xffFFCBBA),
            labelColor: const Color(0xff3E3E3E),
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.mulish(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildPurchaseOrdersTab(), _buildSwapOrdersTab()],
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseOrdersTab() {
    return GetBuilder<MainController>(
      builder: (controller) {
        if (controller.userPurchases.isEmpty) {
          return _buildEmptyState(
            'No Purchase Orders',
            'You haven\'t made any purchases yet',
            CupertinoIcons.bag,
          );
        }

        return ListView.builder(
          itemCount: controller.userPurchases.length,
          itemBuilder: (context, index) {
            final purchase = controller.userPurchases[index];
            return _buildPurchaseCard(purchase);
          },
        );
      },
    );
  }

  Widget _buildSwapOrdersTab() {
    return GetBuilder<MainController>(
      builder: (controller) {
        if (controller.userSwaps.isEmpty) {
          return _buildEmptyState(
            'No Swap Orders',
            'You haven\'t made any swap requests yet',
            CupertinoIcons.arrow_2_circlepath,
          );
        }

        return ListView.builder(
          itemCount: controller.userSwaps.length,
          itemBuilder: (context, index) {
            final swap = controller.userSwaps[index];
            return _buildSwapCard(swap);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.mulish(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.mulish(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseCard(PurchaseModel purchase) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE1E1E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${purchase.purchaseId.substring(0, 8)}',
                style: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff3E3E3E),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: _getStatusColor(purchase.status).withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Text(
              //     purchase.status.toUpperCase(),
              //     style: GoogleFonts.mulish(
              //       fontSize: 12,
              //       color: _getStatusColor(purchase.status),
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total: ₹${purchase.price}',
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Date: ${purchase.purchasedAt.day}/${purchase.purchasedAt.month}/${purchase.purchasedAt.year}',
            style: GoogleFonts.mulish(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapCard(SwapRequestModel swap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE1E1E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Swap #${swap.requestId.substring(0, 8)}',
                style: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff3E3E3E),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(swap.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  swap.status.toUpperCase(),
                  style: GoogleFonts.mulish(
                    fontSize: 12,
                    color: _getStatusColor(swap.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Offered Product: ${swap.offeredProductId.substring(0, 8)}',
            style: GoogleFonts.mulish(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            'Requested Product: ${swap.requestedProductId.substring(0, 8)}',
            style: GoogleFonts.mulish(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            'Date: ${swap.createdAt.day}/${swap.createdAt.month}/${swap.createdAt.year}',
            style: GoogleFonts.mulish(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
      case 'completed':
        return Colors.green;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
    );

    if (shouldLogout == true) {
      await authCtrl.signOut();
      if (mounted) {
        context.go(Routes.home);
      }
    }
  }
}
