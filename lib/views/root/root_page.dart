// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/controllers/manage_sleep_controller.dart';
import 'package:qalgu/views/root/stats/stats_page.dart';
import 'package:qalgu/views/root/tabs/inbox/inbox_page.dart';
import 'package:qalgu/views/root/tabs/setting/setting_page.dart';
import 'package:qalgu/views/root/tabs/sleep/components/sleep_header.dart';
import 'package:qalgu/views/root/tabs/sleep/sleep_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _pages = [
    const SleepPage(),
    const StatsPage(),
    const InboxPage(),
    const SettingPage(),
  ];

  ManageChildController manageChildController =
      Get.put(ManageChildController());
  ManageSleepController manageSleepController =
      Get.put(ManageSleepController());
  @override
  void initState() {
    super.initState();
    manageChildController.getallBabies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsClass.primaryColor,
      // backgroundColor:const Color(0xff6BB5F6).w,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.center,
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
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: Get.height * 0.1),
                    const SleepHeader(),
                    const SizedBox(height: 24),
                    Container(
                      width: Get.width,
                      height: 60,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GetX<ManageChildController>(
                            init: manageChildController,
                            builder: (cont) {
                              return Row(
                                children: List.generate(
                                  cont.getBabylist.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        manageChildController.childIndex.value =
                                            index;
                                        manageChildController.childID =
                                            cont.getBabylist[index].babyId!;
                                        manageSleepController.checkSleepTracker(
                                            manageChildController
                                                .getBabylist[index].babyId!);

                                        manageSleepController.getSleepTrack(
                                            manageChildController
                                                .getBabylist[index].babyId!,
                                            manageChildController.date);
                                        manageSleepController.getDurarion(
                                            manageChildController
                                                .getBabylist[index].babyId!,
                                            'All');
                                      },
                                      child: Obx(
                                        () => Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: index ==
                                                    manageChildController
                                                        .childIndex.value
                                                ? ColorsClass.primaryColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              manageChildController
                                                  .getBabylist[index].babyName!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.dmSans(
                                                  color: index ==
                                                          manageChildController
                                                              .childIndex.value
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Expanded(
                      child: _pages[manageChildController.selectedIndex.value]),
                ),
                Container(
                  width: Get.width,
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bottomNav(0, IconsClass.night, 'Sleep'),
                      bottomNav(1, IconsClass.stats, 'Stats'),
                      bottomNav(2, IconsClass.inbox, 'Inbox'),
                      bottomNav(3, IconsClass.settings, 'Setting'),
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

  Widget bottomNav(int index, String image, String title) {
    return GestureDetector(
      onTap: () {
        manageChildController.selectedIndex.value = index;
      },
      child: Obx(
        () => Column(
          children: [
            Container(
              height: 3,
              width: 19,
              decoration: BoxDecoration(
                  color: index == manageChildController.selectedIndex.value
                      ? ColorsClass.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30)),
            ),
            const SizedBox(height: 17),
            SvgPicture.asset(
              image,
              height: 20,
              color: index == manageChildController.selectedIndex.value
                  ? ColorsClass.primaryColor
                  : const Color(0xff848A92),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.dmSans(
                color: index == manageChildController.selectedIndex.value
                    ? ColorsClass.primaryColor
                    : const Color(0xff848A92),
              ),
            )
          ],
        ),
      ),
    );
  }
}
