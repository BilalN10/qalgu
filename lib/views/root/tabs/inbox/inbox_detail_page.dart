// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/models/inbox_model.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class InboxDetailPage extends StatelessWidget {
  const InboxDetailPage({
    super.key,
    required this.inboxData,
  });
  final InboxModel inboxData;
  @override
  Widget build(BuildContext context) {
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
                  top: Get.height * 0.1,
                  left: 10,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        inboxData.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          inboxData.image,
                          width: Get.width,
                          height: Get.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.15, vertical: 24),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Congratulations Sam! ',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsClass.primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Here is a little poem for you',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "A cheery \"hello\" on your birthday, And wishes for everything bright, May you know only joy and wonder, Morning, noon and night.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff545454)),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05),
                              child: CommonButton(onTap: () {}, title: 'Share'),
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'Back',
                                  style: GoogleFonts.dmSans(
                                      decoration: TextDecoration.underline,
                                      color: ColorsClass.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
