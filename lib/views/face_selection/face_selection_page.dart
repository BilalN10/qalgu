import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/models/child_model.dart';
import 'package:qalgu/models/face_model.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class FaceSelectionPage extends StatefulWidget {
  const FaceSelectionPage(
      {super.key, required this.isFromSignUp, this.babyModel});

  final bool isFromSignUp;
  final BabyModel? babyModel;

  @override
  State<FaceSelectionPage> createState() => _FaceSelectionPageState();
}

class _FaceSelectionPageState extends State<FaceSelectionPage> {
  int selectedIndex = -1;
  ManageChildController manageChildController =
      Get.put(ManageChildController());

  getBabyImagePath() {
    for (int i = 0; i < faceList.length; i++) {
      if (widget.babyModel!.babyImage == faceList[i].image) {
        setState(() {
          selectedIndex = i;
        });
      }
    }
  }

  @override
  void initState() {
    if (widget.babyModel != null) {
      manageChildController.babyImage.value = widget.babyModel!.babyImage!;
      getBabyImagePath();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsClass.primaryColor,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(IconsClass.headerShape)),
            Positioned(
                top: Get.height * 0.06,
                left: 0,
                child: SvgPicture.asset(IconsClass.cloud)),
            Positioned(
              bottom: Get.height * 0.006,
              right: -Get.width * 0.05,
              child: SvgPicture.asset(
                IconsClass.footer,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(.2),
              ),
            ),
            Positioned(
              top: Get.height * 0.14,
              child: Text(
                'QALGU',
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.07,
              child: Container(
                height: Get.height * 0.7,
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
                      SizedBox(height: Get.height * 0.025),
                      Text(
                        widget.babyModel != null
                            ? widget.babyModel!.babyName!
                            : 'Alice Bob',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            color: const Color(0xff2C4FC9),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconsClass.cake,
                            // ignore: deprecated_member_use
                            color: const Color(0xff2C4FC9),
                          ),
                          SizedBox(width: Get.width * 0.01),
                          Text(
                            widget.babyModel != null
                                ? widget.babyModel!.babyDob!
                                : '02/08/2020',
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.025),
                      Container(
                        height: Get.height * 0.42,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Select an Avatar for baby',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xff545454),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.0125),
                              Expanded(
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: faceList.length + 1,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == faceList.length) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = -1;

                                            manageChildController
                                                .babyImage.value = '';
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: Get.height * 0.14,
                                                width: Get.width * 0.28,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      const Color(0xffFFE6BE),
                                                  border: Border.all(
                                                      color: selectedIndex == -1
                                                          ? const Color(
                                                              0xFFFA3DA1)
                                                          : Colors.transparent,
                                                      width: 4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'AB',
                                                    style: GoogleFonts.dmSans(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 5,
                                              child: selectedIndex == -1
                                                  ? const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 12,
                                                      child: CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Color(0xFFFA3DA1),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                            size: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedIndex == index) {
                                            selectedIndex = -1;
                                            manageChildController
                                                .babyImage.value = '';
                                          } else {
                                            selectedIndex = index;

                                            manageChildController
                                                    .babyImage.value =
                                                faceList[selectedIndex].image;
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: selectedIndex == index
                                                ? const Color(0xFFFA3DA1)
                                                : Colors.transparent,
                                            width: 4,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  faceList[index].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 5,
                                                child: selectedIndex == index
                                                    ? const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 12,
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Color(0xFFFA3DA1),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Spacer(),
                      widget.babyModel != null || !widget.isFromSignUp
                          ? CommonButton(
                              onTap: () {
                                Get.back();
                              },
                              title: 'Select',
                            )
                          : Obx(
                              () => manageChildController.isdataAdd.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: ColorsClass.primaryColor,
                                    ))
                                  : CommonButton(
                                      onTap: () {
                                        manageChildController.addBabyData(true);
                                      },
                                      title: 'Continue',
                                    ),
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            widget.babyModel != null || !widget.isFromSignUp
                ? SizedBox()
                : Positioned(
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Skip',
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
