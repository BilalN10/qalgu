import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalgu/service/internet_service.dart';
import 'package:qalgu/views/name/name_page.dart';
import 'package:qalgu/views/root/root_page.dart';

class AuthController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final firebaseUser = Rxn<User>();
  User get users => firebaseUser.value!;
  @override
  void onInit() {
    firebaseUser.bindStream(auth.authStateChanges());

    super.onInit();
  }

  // <========== SIGN UP CONTROLLER ==========>

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  // <========== USER SIGN UP FUNCTION ==========>
  RxBool isSignUp = false.obs;

  Future<void> signUp() async {
    if (await InternetService().checkConnection()) {
      isSignUp.value = true;
      auth
          .createUserWithEmailAndPassword(
              email: emailCont.text.trim(), password: passwordCont.text.trim())
          .then((value) async {
        Map<String, dynamic> userData = {
          'email': emailCont.text,
          'date_time': DateTime.now(),
        };
        await firestore
            .collection('users')
            .doc(value.user!.uid)
            .set(userData)
            .then((value) {
          isSignUp.value = false;
          Get.offAll(() => BabyNamePage());
        });

        clearSignUpCont();
      }).catchError((e) {
        isSignUp.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ));
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  clearSignUpCont() {
    emailCont.clear();
    passwordCont.clear();
  }

  // <========== USER LOGIN FUNCTION ==========>

  RxBool isLogin = false.obs;
  Future<void> login() async {
    print('call');
    isLogin.value = true;
    auth
        .signInWithEmailAndPassword(
            email: emailCont.text.trim(), password: passwordCont.text.trim())
        .then((value) {
      isLogin.value = false;
      Get.offAll(() => const RootPage());

      //Get.offAll(() => const BottomNavPage());
    }).catchError((e) {
      isLogin.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(e.toString()),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }
}
