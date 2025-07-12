import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing/controller/mainController.dart';
import 'package:clothing/models/purchaseModel.dart';
import 'package:clothing/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (hCtrl) {
        final filtered = hCtrl.userPurchases;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Manage Orders",
                style: GoogleFonts.zcoolXiaoWei(
                  fontSize: 20,
                  letterSpacing: .7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Manage purchase details from below",
                style: GoogleFonts.aBeeZee(
                  color: Color(0xff677E77),
                  fontSize: 12,
                  letterSpacing: .7,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 23),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xff677E77),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "All",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: .7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xff677E77),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Pending",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: .7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xff677E77),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Delivered",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: .7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          const OrderTableHeader(),
                          filtered.isEmpty
                              ? const Text('No order to display')
                              : Column(
                                children: [
                                  ...List.generate(filtered.length, (index) {
                                    return Container(
                                      padding: const EdgeInsets.only(left: 12),
                                      decoration:
                                          index % 2 != 0
                                              ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.grey[200],
                                              )
                                              : null,
                                      child: OrderTile(
                                        orderModel: filtered[index],
                                        index: index,
                                        buyerModel: hCtrl.users.firstWhere(
                                          (element) =>
                                              element.uid ==
                                              filtered[index].buyerId,
                                        ),
                                        senderModel: hCtrl.users.firstWhere(
                                          (element) =>
                                              element.uid ==
                                              filtered[index].sellerId,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrderTableHeader extends StatelessWidget {
  const OrderTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const TableHeaderText(headerName: 'Image'),
          const TableHeaderText(headerName: 'Seller Name', size: 300),
          const TableHeaderText(headerName: 'Buyer Name', size: 300),
          const TableHeaderText(headerName: 'Points'),
          const TableHeaderText(headerName: 'Status'),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeaderText extends StatelessWidget {
  const TableHeaderText({super.key, required this.headerName, this.size = 200});
  final String headerName;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: size,
      child: Text(
        headerName,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  const OrderTile({
    super.key,
    required this.orderModel,
    required this.index,
    required this.buyerModel,
    required this.senderModel,
  });
  final PurchaseModel orderModel;
  final int index;
  final UserModel buyerModel;
  final UserModel senderModel;
  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  // bool deleting = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      hoverColor: Colors.transparent,
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            width: 200,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: widget.orderModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            width: 200,
            child: Text(widget.senderModel?.name ?? "-"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            width: 300,
            child: Text(widget.buyerModel.name ?? "-"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            width: 300,
            child: Text(widget.orderModel.price.toString() ?? "-"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            width: 130,
            child: Text("Delivered" ?? "-"),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 15.0 /* top: 7, bottom: 7 */),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
