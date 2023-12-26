import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/views/face_selection/face_selection_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class BornPage extends StatefulWidget {
  const BornPage({
    super.key,
    required this.babyName,
  });
  final String babyName;

  @override
  State<BornPage> createState() => _BornPageState();
}

class _BornPageState extends State<BornPage> {
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        manageChildController.dob = formatter.format(selectedDate);
        print('pick date is ${manageChildController.dob}');
      });
    }
  }

  @override
  void initState() {
    manageChildController.dob = formatter.format(selectedDate);
    print('pick date in build funct ${manageChildController.dob}');

    // TODO: implement initState
    super.initState();
  }

  final ManageChildController manageChildController =
      Get.put(ManageChildController());

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
                        'When was ${widget.babyName} born?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Get.height * 0.025),
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(IconsClass.cake),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Birthday Date',
                                    style: GoogleFonts.dmSans(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.0125),
                              Container(
                                height: Get.height * 0.06,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: ColorsClass.primaryColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // '02/08/2020',
                                        manageChildController.dob,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            selectDate(context);
                                          },
                                          child: SvgPicture.asset(
                                              IconsClass.calendar)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Spacer(),
                      CommonButton(
                        onTap: () => Get.to(() => const FaceSelectionPage(
                              isFromSignUp: true,
                            )),
                        title: 'Continue',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  _showSkipDialog(context);
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.dmSans(
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

  Future<void> _showSkipDialog(BuildContext context) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Center(
                child: Text(
              'Skip?',
              style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
            content: Text(
              'We can deliver better experience if they enter, but they should be able to skip anyway',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(color: Colors.grey, fontSize: 16),
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                        isWhiteButton: true,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: 'Cancel',
                        isBorderEnalbe: true),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                        onTap: () => Get.to(() => const FaceSelectionPage(
                              isFromSignUp: true,
                            )),
                        title: 'Skip'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
