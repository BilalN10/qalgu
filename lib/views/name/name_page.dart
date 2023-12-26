import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/views/name/born_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';
import 'package:qalgu/views/widgets/common_field.dart';

class BabyNamePage extends StatelessWidget {
  BabyNamePage({super.key});

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
                        'What is your baby’s\nname?',
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
                              CommonField(
                                controller: manageChildController.babyName,
                                image: IconsClass.baby,
                                onChanged: (value) {},
                                validator: (value) {
                                  return '';
                                },
                                title: ' Enter Baby Name',
                                hintText: 'Alice Bob',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Spacer(),
                      CommonButton(
                        onTap: () {
                          if (manageChildController
                                  .babyName.value.text.isEmpty ||
                              // ignore: unnecessary_null_comparison
                              manageChildController.babyName.value.text ==
                                  null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please Enter Name of baby')));
                          } else {
                            Get.to(() => BornPage(
                                  babyName:
                                      manageChildController.babyName.value.text,
                                ));
                          }
                        },
                        title: 'Continue',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
