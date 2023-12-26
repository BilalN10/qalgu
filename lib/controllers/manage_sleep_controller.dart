import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qalgu/controllers/auth_controller.dart';
import 'package:qalgu/models/sleep_trac_model.dart';
import 'package:qalgu/service/internet_service.dart';

class ManageSleepController extends GetxController {
  AuthController authController = Get.put(AuthController());
  InternetService internetService = InternetService();

  // <========== RECORD SLEEP ==========>

  RxBool isStartrecord = false.obs;
  Future<void> recordSleep(String childId) async {
    if (await internetService.checkConnection()) {
      isStartrecord.value = true;
      DateTime startTime = DateTime.now();

      Map<String, dynamic> sleepData = {
        'start_sleep': startTime.toLocal().toString(),
        'end_sleep': '',
        'sleep_type': getSleepType(startTime.hour),
        'date': startTime.toLocal().toString().split(' ').first,
        'child_id': childId,
        'sleep_duration': '',
        'date_time': DateTime.now(),
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.auth.currentUser!.uid)
          .collection('sleep_track')
          .add(sleepData)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(authController.auth.currentUser!.uid)
            .collection('child')
            .doc(childId)
            .update({'sleep_track_on': true}).then((value) async {
          await checkSleepTracker(childId);
          isStartrecord.value = false;
        });
      });
    } else {
      isStartrecord.value = false;

      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  String getSleepType(int startHour) {
    if (startHour >= 18 || startHour < 6) {
      return 'Night Sleep';
    } else {
      return 'Day Sleep';
    }
  }

  // <========== STOP SLEEP ==========>

  DateTime startTime(String startSleep) {
    DateTime dateTime = DateTime.parse(startSleep);

    return dateTime;
  }

  RxBool isStopSleep = false.obs;

  Future<void> stopSleep(SleepTrackModel sleepTrackModel) async {
    if (await internetService.checkConnection()) {
      isStopSleep.value = true;
      DateTime endSleep = DateTime.now();
      DateTime now = DateTime.now();
      Duration difference =
          now.difference(startTime(sleepTrackModel.startSleep!));
      // Sleep duration will be record in minutes
      double minutes = difference.inMinutes.remainder(60);

      Map<String, dynamic> sleepData = {
        'end_sleep': endSleep.toLocal().toString(),
        'sleep_duration': minutes.toString(),
      };

      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.auth.currentUser!.uid)
          .collection('sleep_track')
          .doc(sleepTrackModel.id)
          .update(sleepData)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(authController.auth.currentUser!.uid)
            .collection('child')
            .doc(sleepTrackModel.childId!)
            .update({'sleep_track_on': false}).then((value) async {
          await checkSleepTracker(sleepTrackModel.childId!);
        });
        addDuration(
            sleepTrackModel.childId!, minutes, sleepTrackModel.sleepType!);
      });
      isStopSleep.value = false;
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
  // <========== ADD DURATION TO SHOW GRAPH ==========>

  addDuration(String childId, double duration, String sleepType) {
    DateTime now = DateTime.now();
    String dateFormat = DateFormat('d/M').format(now);
    Map<String, dynamic> durationData = {
      'name': dateFormat,
      'value': duration,
      'date_time': now,
      'sleep_type': sleepType
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(authController.auth.currentUser!.uid)
        .collection('child')
        .doc(childId)
        .collection('sleep_duration')
        .doc(now.toLocal().toString().split(' ').first)
        .get()
        .then((value) {
      if (value.exists) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(authController.auth.currentUser!.uid)
            .collection('child')
            .doc(childId)
            .collection('sleep_duration')
            .doc(now.toLocal().toString().split(' ').first)
            .update({'value': value['value'] + duration});
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(authController.auth.currentUser!.uid)
            .collection('child')
            .doc(childId)
            .collection('sleep_duration')
            .doc(now.toLocal().toString().split(' ').first)
            .set(durationData);
      }
    });
  }

  // <========== CHECK SLEEP TRACK ==========>

  RxBool isSleepTrackOn = false.obs;

  Future<bool> checkSleepTracker(String childId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authController.auth.currentUser!.uid)
            .collection('child')
            .doc(childId)
            .get();
    if (documentSnapshot.exists) {
      isSleepTrackOn.value = documentSnapshot.data()!['sleep_track_on'];
      print('seelp track is $isSleepTrackOn ');
    }
    return isSleepTrackOn.value;
  }

  // <========== GET ALL SLEEP TRACK==========>

  Rx<List<SleepTrackModel>> sleepTrackList = Rx<List<SleepTrackModel>>([]);
  List<SleepTrackModel> get getsleepTrackList => sleepTrackList.value;

  getSleepTrack(String childId, String date) {
    sleepTrackList.bindStream(getaSleepTrackStream(childId, date));
  }

  Stream<List<SleepTrackModel>> getaSleepTrackStream(
      String childId, String date) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authController.auth.currentUser!.uid)
        .collection('sleep_track')
        .where('child_id', isEqualTo: childId)
        .where('date', isEqualTo: date)
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<SleepTrackModel> retVal = [];
      for (int index = 0; index < event.docs.length; index++) {
        var element = event.docs[index];
        retVal.add(SleepTrackModel.fromSnamshot(
          element,
        ));
      }
      return retVal;
    });
  }

  // <========== GET ALL SLEEP TRACK==========>

  Rx<List<Map<String, Object>>> duration = Rx<List<Map<String, Object>>>([]);
  List<Map<String, Object>> get getdurationList => duration.value;

  getDurarion(String childId, String sleepType) {
    duration.bindStream(getDurarionStream(childId, sleepType));
  }

  Stream<List<Map<String, Object>>> getDurarionStream(
      String childId, String sleepType) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authController.auth.currentUser!.uid)
        .collection('child')
        .doc(childId)
        .collection('sleep_duration')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<Map<String, Object>> retVal = [];
      for (int index = 0; index < event.docs.length; index++) {
        var element = event.docs[index];

        retVal.add({
          'name': element.data()['name'],
          'value': element.data()['value'],
        });
      }
      print('sleep length is ${retVal.length}');
      return retVal;
    });
  }
}
