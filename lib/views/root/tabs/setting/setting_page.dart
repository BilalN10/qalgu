import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/root/anny_access/nanny_access_page.dart';
import 'package:qalgu/views/root/manage_children/manage_children_page.dart';
import 'package:qalgu/views/root/tabs/setting/account_settings_page.dart';

import 'components/setting_tile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 25),
            SettingTile(
              onTap: () => Get.to(() => AccountSettingsPage()),
              image: IconsClass.accountSetting,
              title: 'Account Settings',
            ),
            const SizedBox(height: 15),
            SettingTile(
              onTap: () => Get.to(() => const ManageChildrenPage()),
              image: IconsClass.manageChildren,
              title: 'Manage Children',
            ),
            const SizedBox(height: 15),
            SettingTile(
              onTap: () => Get.to(() => const NannyAccessPage()),
              image: IconsClass.nanny,
              title: 'Manage Family or Nanny Access',
            ),
            const SizedBox(height: 15),
            SettingTile(
              onTap: () {},
              image: IconsClass.feedback,
              title: 'Write Us Feedback',
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Delete Account',
                  style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      decoration: TextDecoration.underline),
                )),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
