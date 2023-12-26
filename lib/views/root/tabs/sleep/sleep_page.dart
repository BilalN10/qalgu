import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:intl/intl.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/controllers/manage_sleep_controller.dart';
import 'package:qalgu/models/sleep_trac_model.dart';
import 'package:qalgu/views/widgets/common_button.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  DateTime currentDate = DateTime.now();
  bool isToday = true;
  void updateDate(bool isNext) {
    final newDate = isNext
        ? currentDate.add(const Duration(days: 1))
        : currentDate.subtract(const Duration(days: 1));
    final today = DateTime.now();

    setState(() {
      currentDate = newDate;
      isToday = newDate.year == today.year &&
          newDate.month == today.month &&
          newDate.day == today.day;
    });
    manageChildController.date = DateFormat('y-M-d').format(currentDate);
    manageSleepController.getSleepTrack(
        manageChildController.childID, manageChildController.date);

    print('current date is ${DateFormat('y-M-d').format(currentDate)}');
  }

  DateTime? startTime;

  ManageSleepController manageSleepController =
      Get.put(ManageSleepController());
  ManageChildController manageChildController =
      Get.put(ManageChildController());

  @override
  void initState() {
    DateTime currentDate = DateTime.now();

    manageSleepController.getSleepTrack(
        manageChildController.childID, DateFormat('y-M-d').format(currentDate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 44,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorsClass.primaryColor,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          updateDate(false);
                        });
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: ColorsClass.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(IconsClass.arrowLeft),
                        ),
                      ),
                    ),
                    Text(
                      isToday
                          ? 'Today'
                          : DateFormat('y-M-d').format(currentDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          updateDate(true);
                        });
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: ColorsClass.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(IconsClass.arrowRight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GetX<ManageSleepController>(
                init: Get.put(ManageSleepController()),
                builder: (cont) {
                  return ListView.builder(
                    itemCount: cont.getsleepTrackList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == cont.getsleepTrackList.length) {
                        print('index is equal');
                        return Obx(
                          () => manageSleepController.isSleepTrackOn.value
                              ? SizedBox()
                              : Column(
                                  children: [
                                    isToday
                                        ? CommonButton(
                                            onTap: () {
                                              manageSleepController.recordSleep(
                                                  manageChildController
                                                      .childID);

                                              // startTime = DateTime.now();
                                              // print('End Time: ${startTime!.toLocal()}');
                                              // print('End Time: ${startTime!.hour}');
                                              // print('End Time: ${startTime!.minute}');
                                            },
                                            title: 'Record Sleep',
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                        );
                      } else {
                        print('not equal');
                        return SleepTile(
                          sleepTrackModel: cont.getsleepTrackList[index],
                        );
                      }
                    },
                  );
                }),
          ),
          // sleepList[1].isStopRecord
          //     ? const SizedBox()
          //     : CommonButton(
          //         onTap: () {},
          //         title: 'Record Sleep',
          //       ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class SleepTile extends StatelessWidget {
  SleepTile({
    super.key,
    required this.sleepTrackModel,
  });
  final SleepTrackModel sleepTrackModel;

  DateTime startTime() {
    DateTime dateTime = DateTime.parse(sleepTrackModel.startSleep!);

    return dateTime;
  }

  DateTime endTime() {
    DateTime dateTime = DateTime.parse(sleepTrackModel.endSleep!);

    return dateTime;
  }

  String calculateTimeDifference() {
    String timeDifference = '';
    DateTime? endSleepTime;
    if (sleepTrackModel.endSleep!.isNotEmpty) {
      endSleepTime = endTime();
    } else {
      endSleepTime = DateTime.now();
    }
    Duration difference = endSleepTime.difference(startTime());
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    if (hours == 0 && minutes == 0) {
      timeDifference = "$seconds seconds";
    } else if (hours == 0) {
      timeDifference = "$minutes minutes";
    } else {
      timeDifference = "$hours hours, $minutes minutes";
    }

    return timeDifference; //'$hours hours, $minutes minutes, $seconds ';
  }

  final ManageSleepController manageSleepController =
      Get.put(ManageSleepController());

  @override
  Widget build(BuildContext context) {
    calculateTimeDifference();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 22,
                      width: 42,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorsClass.primaryColor)),
                      child: Center(
                        child: Text(
                          startTime().hour.toString().length == 1 &&
                                  startTime().minute.toString().length == 1
                              ? "0${startTime().hour.toString()}:0${startTime().minute.toString()} "
                              : startTime().hour.toString().length == 1
                                  ? "0${startTime().hour.toString()}:${startTime().minute.toString()}"
                                  : startTime().minute.toString().length == 1
                                      ? "${startTime().hour.toString()}:0${startTime().minute.toString()}"
                                      : "${startTime().hour.toString()}:${startTime().minute.toString()}",
                          style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    sleepTrackModel.endSleep!.isEmpty
                        ? const SizedBox()
                        : Container(
                            height: 22,
                            width: 42,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorsClass.primaryColor)),
                            child: Center(
                              child: Text(
                                endTime().hour.toString().length == 1 &&
                                        endTime().minute.toString().length == 1
                                    ? "0${endTime().hour.toString()}:0${endTime().minute.toString()} "
                                    : endTime().hour.toString().length == 1
                                        ? "0${endTime().hour.toString()}:${endTime().minute.toString()}"
                                        : endTime().minute.toString().length ==
                                                1
                                            ? "${endTime().hour.toString()}:0${endTime().minute.toString()}"
                                            : "${endTime().hour.toString()}:${endTime().minute.toString()}",
                                style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                // height: 80,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sleepTrackModel.sleepType!,
                                style: GoogleFonts.dmSans(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                calculateTimeDifference(),
                                style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: ColorsClass.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.light_mode_outlined,
                              color: ColorsClass.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    sleepTrackModel.endSleep!.isEmpty
                        ? Obx(
                            () => manageSleepController.isStopSleep.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsClass.primaryColor,
                                    ),
                                  )
                                : SizedBox(
                                    width: Get.width * 0.8,
                                    height: Get.height * 0.065,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(16),
                                                ),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ColorsClass.primaryColor)),
                                        onPressed: () {
                                          manageSleepController
                                              .stopSleep(sleepTrackModel);
                                        },
                                        child: Text(
                                          'Stop Sleep',
                                          style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
