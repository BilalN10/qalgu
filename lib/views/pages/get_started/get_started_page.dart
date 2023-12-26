import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/constants/images.dart';
import 'package:qalgu/views/pages/find_us/find_us_page.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: ColorsClass.primaryColor,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(IconsClass.headerShape),
            ),
            Positioned(
                top: Get.height * 0.2,
                child: SvgPicture.asset(ImagesClass.getStarted)),
            Positioned(
              left: Get.width * 0.05,
              top: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'With ',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SvgPicture.asset(IconsClass.fav),
                  Text(
                    ' from mom who created this app ',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Get.height * 0.25,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: SizedBox(
                  width: Get.width * 0.8,
                  child: Text(
                    "Let Simple Baby sleep tracker support you on your child's unique sleep development path!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.15,
              right: -Get.width * 0.1,
              child: SvgPicture.asset(
                IconsClass.footer,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(.2),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.05,
              child: CommonButton(
                onTap: () => Get.offAll(() => const FindUsPage()),
                title: 'Next',
                isWhiteButton: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
