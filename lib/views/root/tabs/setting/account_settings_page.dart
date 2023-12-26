// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/icons.dart';
import 'components/animated_switch.dart';
import 'components/setting_appbar.dart';
import 'components/update_credentials.dart';
import 'components/upgrade_tile.dart';

class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SettingAppbar(title: 'Account Settings'),
                          const SizedBox(height: 20),
                          const UpgradeTile(),
                          const SizedBox(height: 20),
                          UpdateCredentials(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Notifications Settings',
                            style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 54,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(IconsClass.inbox),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'SMS Notifications',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  const AnimatedSwitch(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 54,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(IconsClass.email),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Email Notifications',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  const AnimatedSwitch(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
