import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qalgu/controllers/auth_controller.dart';
import 'package:qalgu/controllers/manage_sleep_controller.dart';
import 'package:qalgu/models/child_model.dart';
import 'package:qalgu/service/internet_service.dart';
import 'package:qalgu/views/root/root_page.dart';

class ManageChildController extends GetxController {
  AuthController authController = Get.put(AuthController());
  ManageSleepController manageSleepController =
      Get.put(ManageSleepController());
  RxInt selectedIndex = 0.obs;
  RxInt childIndex = 0.obs;
  String childID = '';
  String date = '';

  // <========== ADD BABY DATA ==========>

  TextEditingController babyName = TextEditingController();
  String dob = '';
  RxString babyImage = ''.obs;
  RxBool isdataAdd = false.obs;
  Future<void> addBabyData(bool isFromSigUp) async {
    if (await InternetService().checkConnection()) {
      isdataAdd.value = true;
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.auth.currentUser!.uid)
          .collection('child')
          .add({
        'baby_name': babyName.text,
        'dob': dob,
        'baby_image': babyImage.value,
        'date_time': DateTime.now(),
        'sleep_track_on': false
      }).then((value) {
        isdataAdd.value = false;
        if (isFromSigUp) {
          Get.offAll(() => const RootPage());
        } else {
          Get.back();
        }
      });
    } else {
      isdataAdd.value = false;

      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  // <========== GET ALL BABIES DATA ==========>

  Rx<List<BabyModel>> babyList = Rx<List<BabyModel>>([]);
  List<BabyModel> get getBabylist => babyList.value;

  Future<void> getallBabies() async {
    babyList.bindStream(getallBabiesStream());
  }

  Stream<List<BabyModel>> getallBabiesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authController.auth.currentUser!.uid)
        .collection('child')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<BabyModel> retVal = [];
      for (int index = 0; index < event.docs.length; index++) {
        var element = event.docs[index];
        retVal.add(BabyModel.fromSnamshot(
          element,
        ));
        if (childID.isEmpty) {
          if (index == 0) {
            childID = event.docs[index].id;
            fetchChildSpeelTrackData(childID);
          }
        }
      }
      return retVal;
    });
  }

  // <========== FETCH CHILD SLEEP TRACK DATA ==========>

  fetchChildSpeelTrackData(String childId) {
    DateTime currentDate = DateTime.now();
    date = DateFormat('y-M-d').format(currentDate);

    manageSleepController.getSleepTrack(childID, date);
    manageSleepController.checkSleepTracker(childID);
    manageSleepController.getDurarion(childID, 'All');
  }
  // <========== CALCULATE DATE OF BIRTH ==========>

  String calculateDateofBirth(String dateOfBirth) {
    String dob = '';
    // Input date string

    // Convert string to DateTime object
    DateTime dobDate = DateFormat("dd/MM/yyyy").parse(dateOfBirth);

    // Calculate age (assuming current date is today, you may need to adjust accordingly)
    DateTime currentDate = DateTime.now();
    Duration ageDifference = currentDate.difference(dobDate);

    // Calculate age in years and months
    int years = ageDifference.inDays ~/ 365;
    int months = ((ageDifference.inDays % 365) / 30).floor();
    if (months > 0) {
      dob = "$years years and $months months old";
    } else {
      dob = "$years years old";
    }

    return dob;
  }

  // <========== Update BABY DATA ==========>

  RxBool isdataUpdate = false.obs;
  Future<void> updateBabyData(String docId) async {
    if (await InternetService().checkConnection()) {
      isdataUpdate.value = true;
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.auth.currentUser!.uid)
          .collection('child')
          .doc(docId)
          .update({
        'baby_name': babyName.text,
        'dob': dob,
        'baby_image': babyImage.value,
      }).then((value) {
        isdataUpdate.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Data updated successfully'),
          behavior: SnackBarBehavior.floating,
        ));
      }).catchError((e) {
        isdataUpdate.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ));
      });
    } else {
      isdataUpdate.value = false;

      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
