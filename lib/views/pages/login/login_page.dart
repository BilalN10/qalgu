import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/constants/maxin_validation.dart';
import 'package:qalgu/controllers/auth_controller.dart';
import 'package:qalgu/views/widgets/common_button.dart';
import 'package:qalgu/views/widgets/common_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLogin = true;
  final formkey = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());

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
              bottom: Get.height * 0.06,
              child: Container(
                height: Get.height * 0.75,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.04),
                        Text(
                          isLogin ? 'Login' : 'Sign Up',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          isLogin
                              ? 'Enter your email and password to login'
                              : 'Enter your email and password to Sign Up',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              color: const Color(0xff545454),
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: Get.height * 0.06),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CommonField(
                                  controller: authController.emailCont,
                                  image: IconsClass.email,
                                  title: 'Email',
                                  hintText: 'alice.bob@gmail.com',
                                  onChanged: (value) {},
                                  validator: (email) {
                                    return isEmailValid(email!)
                                        ? null
                                        : 'Invalid email address';
                                  },
                                ),
                                SizedBox(height: Get.height * 0.03),
                                CommonField(
                                  isObscure: true,
                                  controller: authController.passwordCont,
                                  image: IconsClass.lock,
                                  title: 'Password',
                                  hintText: '**********',
                                  onChanged: (value) {},
                                  validator: (password) {
                                    return isPasswordValid(password!)
                                        ? null
                                        : 'Password must greater then or equla to 8 characters';
                                  },
                                ),
                                SizedBox(height: Get.height * 0.04),
                                isLogin
                                    ? Obx(
                                        () => authController.isLogin.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: ColorsClass.primaryColor,
                                              ))
                                            : CommonButton(
                                                onTap: () {
                                                  if (formkey.currentState!
                                                      .validate()) {
                                                    authController.login();
                                                  }
                                                },
                                                title: 'Login',
                                              ),
                                      )
                                    : Obx(
                                        () => authController.isSignUp.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: ColorsClass.primaryColor,
                                              ))
                                            : CommonButton(
                                                onTap: () {
                                                  if (formkey.currentState!
                                                      .validate()) {
                                                    authController.signUp();
                                                  }
                                                },
                                                title: 'Sign Up',
                                              ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            isLogin ? 'Or sign in with' : 'Or sign Up with',
                            style: GoogleFonts.dmSans(
                                color: const Color(0xff545454),
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(IconsClass.apple),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(IconsClass.google),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(IconsClass.facebook),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: isLogin
                              ? 'Don’t have an account '
                              : 'Already have and account ',
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                          text: isLogin ? 'Register' : 'Login',
                          style: GoogleFonts.dmSans(
                              color: const Color(0xff2C4FC9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
