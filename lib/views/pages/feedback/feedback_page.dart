import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/pages/congrats/congrats_page.dart';
import 'package:qalgu/views/pages/login/login_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedIndex = 0;
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
              bottom: Get.height * 0.006,
              right: -Get.width * 0.05,
              child: SvgPicture.asset(
                IconsClass.footer,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(.2),
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
                      SizedBox(height: Get.height * 0.04),
                      Text(
                        'How much do you agree with something?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Get.height * 0.06),
                      Container(
                        height: Get.height * 0.3,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildToggleItem(0, IconsClass.disagree),
                                buildToggleItem(1, IconsClass.neutral),
                                buildToggleItem(2, IconsClass.agree),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.04),
                            Text(
                              selectedIndex == 0
                                  ? 'Disagree'
                                  : selectedIndex == 1
                                      ? 'Neutral'
                                      : 'Agree',
                              style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Spacer(),
                      CommonButton(
                        onTap: () => Get.to(() => const CongratsPage()),
                        title: 'Next',
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
                  onTap: () => Get.to(() => LoginPage()),
                  child: Text(
                    'Skip to Login',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildToggleItem(int index, String icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 50,
        width: Get.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? const Radius.circular(40.0) : Radius.zero,
            topRight: index == 2 ? const Radius.circular(40.0) : Radius.zero,
            bottomLeft: index == 0 ? const Radius.circular(40.0) : Radius.zero,
            bottomRight: index == 2 ? const Radius.circular(40.0) : Radius.zero,
          ),
          color: ColorsClass.primaryColor
              .withOpacity(index == selectedIndex ? 1 : 0.2),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              // ignore: deprecated_member_use
              color: index == selectedIndex
                  ? Colors.white
                  : ColorsClass.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
