// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/models/child_model.dart';
import 'package:qalgu/views/root/manage_children/edit_manage_children_page.dart';
import 'package:qalgu/views/root/tabs/setting/components/setting_appbar.dart';

class ManageChildrenPage extends StatelessWidget {
  const ManageChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsClass.primaryColor,
        onPressed: () {
          Get.to(() => EditManageChildrenPage());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                ),
                Positioned(
                    top: 0,
                    left: -100,
                    child: Image.asset(
                      'assets/images/root_header.png',
                      fit: BoxFit.cover,
                      width: Get.width,
                    )),
                Positioned(
                    top: Get.height * 0.06,
                    left: 0,
                    child: SvgPicture.asset(IconsClass.cloud)),
                Positioned(
                  bottom: Get.height * 0.006,
                  right: -Get.width * 0.05,
                  child: SvgPicture.asset(
                    IconsClass.footer,
                    color: Colors.white.withOpacity(.2),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.05,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingAppbar(title: 'Manage Children'),
                      SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: GetX<ManageChildController>(
                            init: Get.put(ManageChildController()),
                            builder: (cont) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: cont.getBabylist.length,
                                itemBuilder: (context, index) {
                                  BabyModel babyModel = cont.getBabylist[index];
                                  return ChildTile(
                                    babyModel: babyModel,
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChildTile extends StatefulWidget {
  const ChildTile({
    super.key,
    required this.babyModel,
  });

  final BabyModel babyModel;

  @override
  State<ChildTile> createState() => _ChildTileState();
}

class _ChildTileState extends State<ChildTile> {
  String dateOfBirth = '';
  @override
  void initState() {
    dateOfBirth =
        manageChildController.calculateDateofBirth(widget.babyModel.babyDob!);
    super.initState();
  }

  ManageChildController manageChildController =
      Get.put(ManageChildController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 54,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.babyModel.babyImage!),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.30,
                    child: Text(
                      widget.babyModel.babyName!,
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.40,
                    child: Text(
                      dateOfBirth,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff545454),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => EditManageChildrenPage(
                      babyModel: widget.babyModel,
                    )),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff6BB5F6),
                        Color(0xff52A3EB),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      IconsClass.edit,
                      height: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff6BB5F6),
                      Color(0xff52A3EB),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    IconsClass.trash,
                    height: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
