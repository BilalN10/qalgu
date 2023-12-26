// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/models/child_model.dart';
import 'package:qalgu/views/face_selection/face_selection_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';
import 'package:qalgu/views/widgets/common_field.dart';

class EditManageChildrenPage extends StatefulWidget {
  const EditManageChildrenPage({super.key, this.babyModel});

  final BabyModel? babyModel;

  @override
  State<EditManageChildrenPage> createState() => _EditManageChildrenPageState();
}

class _EditManageChildrenPageState extends State<EditManageChildrenPage> {
  ManageChildController manageChildController =
      Get.put(ManageChildController());
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        manageChildController.dob = formatter.format(selectedDate);
      });
    }
  }

  File? image;
  Future pickImage(ImageSource sr) async {
    try {
      final image = await ImagePicker().pickImage(source: sr);
      if (image == null) {}
      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('failed to pick image: $e');
    }
  }

  @override
  void initState() {
    if (widget.babyModel != null) {
      manageChildController.isdataUpdate.value = false;
      manageChildController.babyName.text = widget.babyModel!.babyName!;
      manageChildController.babyImage.value = widget.babyModel!.babyImage!;
      manageChildController.dob = widget.babyModel!.babyDob!;
    } else {
      manageChildController.babyImage.value = 'assets/baby_face/6.png';
      selectedDate = DateTime.now();
      manageChildController.dob = formatter.format(selectedDate);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final String formatted =
    return Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SettingAppbar(title: 'Manage Children'),
                      SizedBox(height: Get.height * 0.1),
                      Container(
                        height: Get.height * 0.66,
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => FaceSelectionPage(
                                              babyModel: widget.babyModel,
                                              isFromSignUp: false,
                                            ));
                                        //pickImage(ImageSource.camera);
                                      },
                                      child: Obx(
                                        () => CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              manageChildController
                                                  .babyImage.value),
                                        ),
                                      )),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                          onTap: () {
                                            //  pickImage(ImageSource.camera);
                                            Get.to(() => FaceSelectionPage(
                                                  babyModel: widget.babyModel,
                                                  isFromSignUp: false,
                                                ));
                                          },
                                          child: Image.asset(
                                              IconsClass.pickImage))),
                                ],
                              ),
                              const SizedBox(height: 30),
                              // const Spacer(),
                              Container(
                                // height: Get.height * 0.2,
                                width: Get.width * 0.8,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonField(
                                        controller: widget.babyModel != null
                                            ? manageChildController.babyName
                                            : manageChildController.babyName,
                                        image: IconsClass.baby,
                                        onChanged: (value) {},
                                        validator: (value) {
                                          return '';
                                        },
                                        title: ' Name',
                                        hintText: 'Alice Bob',
                                      ),
                                      Container(
                                        height: Get.height * 0.2,
                                        width: Get.width * 0.8,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      IconsClass.cake),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    'Birthday',
                                                    style: GoogleFonts.dmSans(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.0125),
                                              Container(
                                                height: Get.height * 0.06,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: ColorsClass
                                                          .primaryColor),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        // '02/08/2020',
                                                        manageChildController
                                                            .dob,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            selectDate(context);
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment
                                                                    .topRight,
                                                                end: Alignment
                                                                    .bottomLeft,
                                                                colors: [
                                                                  Color(
                                                                      0xffFFFFFF),
                                                                  Color(
                                                                      0xffE7E7E7),
                                                                ],
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: SvgPicture
                                                                  .asset(IconsClass
                                                                      .calendar),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Obx(
                                () => manageChildController.isdataUpdate.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorsClass.primaryColor,
                                        ),
                                      )
                                    : CommonButton(
                                        onTap: () {
                                          if (manageChildController
                                              .babyName.text.isNotEmpty) {
                                            if (widget.babyModel != null) {
                                              manageChildController
                                                  .updateBabyData(widget
                                                      .babyModel!.babyId!);
                                            } else {
                                              manageChildController
                                                  .addBabyData(false);
                                            }
                                          } else {
                                            ScaffoldMessenger.of(Get.context!)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please enter baby name'),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ));
                                          }
                                        },

                                        // else {
                                        //   Get.to(() => BornPage(
                                        //         babyName: nameController.value.text,
                                        //       ));
                                        // }

                                        title: widget.babyModel != null
                                            ? 'Save'
                                            : 'ADD',
                                      ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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
