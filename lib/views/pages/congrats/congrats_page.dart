import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/name/name_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

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
                      Container(
                        height: Get.height * 0.5,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor:
                                  ColorsClass.primaryColor.withOpacity(.1),
                              child: SvgPicture.asset(IconsClass.congrats),
                            ),
                            SizedBox(height: Get.height * 0.07),
                            Text(
                              'Congratulations!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.09),
                              child: Text(
                                'You scored a 25% Mother’s Day coupon discount! It will be applied automatically.!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                    color: const Color(0xff545454),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Spacer(),
                      CommonButton(
                        onTap: () => Get.to(() => BabyNamePage()),
                        title: 'Yay!',
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
