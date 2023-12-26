import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/pages/login/login_page.dart';
import 'package:qalgu/views/pages/subscription/subscription_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class FindUsPage extends StatefulWidget {
  const FindUsPage({super.key});

  @override
  State<FindUsPage> createState() => _FindUsPageState();
}

class _FindUsPageState extends State<FindUsPage> {
  String selectedOption = '';
  void handleTileTap(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  Widget buildTile(String option, String text, String icon) {
    return GestureDetector(
      onTap: () {
        handleTileTap(option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: option == selectedOption
                ? ColorsClass.primaryColor
                : Colors.white,
            width: 2.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: option == selectedOption
                    ? ColorsClass.primaryColor
                    : ColorsClass.primaryColor.withOpacity(.1),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  // ignore: deprecated_member_use
                  color: option == selectedOption
                      ? Colors.white
                      : ColorsClass.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              text,
              style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: option == selectedOption
                      ? ColorsClass.primaryColor
                      : Colors.black),
            ),
            const Spacer(),
            Radio(
              activeColor: ColorsClass.primaryColor,
              fillColor: MaterialStateProperty.all(ColorsClass.primaryColor),
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                handleTileTap(value as String);
              },
            ),
          ],
        ),
      ),
    );
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
                        'Glad you found us! How did you hear about us?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Get.height * 0.06),
                      buildTile(
                          'from_search', 'From Search', IconsClass.search),
                      SizedBox(height: Get.height * 0.02),
                      buildTile(
                          'from_friends', 'From Friends', IconsClass.person),
                      SizedBox(height: Get.height * 0.02),
                      buildTile('from_social_media', 'From Social Media',
                          IconsClass.socialmedia),
                      const Spacer(),
                      CommonButton(
                        onTap: () => Get.to(() => const SubscriptionPage()),
                        title: 'Next',
                      ),
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
}
