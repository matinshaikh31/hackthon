import 'package:clothing/shared/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key, required this.child});
  final Widget child;
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f8f6),
      appBar: AdminAppBar(preferedSize: Size.fromHeight(70)),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: MediaQuery.sizeOf(context).width * 0.07,
        ),
        child: Column(
          children: [
            Row(
              children: [
                TabsWid(
                  icon: CupertinoIcons.person_3_fill,
                  textName: 'Users',
                  route: Routes.users,
                ),

                SizedBox(width: 20),

                TabsWid(
                  icon: CupertinoIcons.bag,
                  textName: 'Orders',
                  route: Routes.orders,
                ),
                SizedBox(width: 20),
                TabsWid(
                  icon: CupertinoIcons.settings,
                  textName: 'Settings',
                  route: Routes.settings,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.sizeOf(context).height - 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20),

                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabsWid extends StatelessWidget {
  const TabsWid({
    super.key,
    required this.icon,
    required this.textName,
    // required this.isSelected,
    // this.scafKey,
    required this.route,
    this.refresh,
  });
  final IconData icon;
  final String textName;
  final Function()? refresh;
  // final bool isSelected;
  // final GlobalKey<ScaffoldState>? scafKey;
  final String route;
  @override
  Widget build(BuildContext context) {
    final selected = appRouter.routeInformationProvider.value.uri.path == route;
    return Expanded(
      child: InkWell(
        onTap: () {
          context.go(route);
          refresh;
          // scafKey?.currentState?.closeDrawer();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Color(0xff45a073) : Colors.transparent,
            border: selected ? null : Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF6C6C6C),
                size: 21,
              ),
              const SizedBox(width: 10),
              Text(
                textName,
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key, required this.preferedSize});
  final Size preferedSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      // height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
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
              ],
            ),
          ),
          Container(
            width: 120,
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(width: 120),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferedSize;
}
