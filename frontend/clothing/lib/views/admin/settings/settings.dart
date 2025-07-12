import 'package:clothing/controller/mainController.dart';
import 'package:clothing/shared/firebase.dart';
import 'package:clothing/shared/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (hCtrl) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Inventories",
                style: GoogleFonts.zcoolXiaoWei(
                  fontSize: 20,
                  letterSpacing: .7,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Configure your platform preferences",
                style: GoogleFonts.aBeeZee(
                  color: Color(0xff677E77),
                  fontSize: 12,
                  letterSpacing: .7,

                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 23),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Package Services',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: .8,
                        // color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        addEditPackageService(context, null);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 125, 125, 125),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.square_grid_2x2,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Service",
                              style: TextStyle(
                                fontSize: 13.5,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                    left: BorderSide(color: Colors.grey.shade300),
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: StaggeredGrid.extent(
                  maxCrossAxisExtent: 350,
                  // alignment: WrapAlignment.start,
                  // runAlignment: WrapAlignment.start,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    ...List.generate(hCtrl.settings?.categories.length ?? 0, (
                      index,
                    ) {
                      final service = hCtrl.settings?.categories[index];
                      return InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          addEditPackageService(context, service);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          // width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 230, 230, 230),
                                ),
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff6C6C6C),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  capilatlizeFirstLetter(service ?? '-'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff3E3E3E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

addEditPackageService(BuildContext context, String? packageService) async {
  bool loading = false;
  final serviceNameCtrl = TextEditingController();
  if (packageService != null) {
    serviceNameCtrl.text = packageService;
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            // backgroundColor: dashboardColor,
            // surfaceTintColor: dashboardColor,
            // shadowColor: dashboardColor,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            title: Text(
              packageService != null ? "Edit Service" : "Add Service",
            ),
            content: SizedBox(
              width: 280,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: serviceNameCtrl,
                    cursorHeight: 20,
                    decoration: inpDecor().copyWith(labelText: 'Name'),
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions:
                loading
                    ? [
                      Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ]
                    : [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          if (loading) return;

                          if (serviceNameCtrl.text.trim().isEmpty) {
                            showErrorAppSnackBar(context, 'Name Required');
                            return;
                          }

                          try {
                            setState2(() {
                              loading = true;
                            });

                            await FBFireStore.setting.update({
                              'categories': FieldValue.arrayUnion([
                                serviceNameCtrl.text.trim(),
                              ]),
                            });
                            setState2(() {
                              loading = false;
                            });

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              showAppSnackBar(
                                packageService != null
                                    ? 'Service Updated'
                                    : 'Service Added',
                              );
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                            showAppSnackBar(e.toString());
                          }
                        },
                        child: const Text("Save"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
          );
        },
      );
    },
  );
}
