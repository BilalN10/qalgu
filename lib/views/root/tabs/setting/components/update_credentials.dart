import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/widgets/common_button.dart';
import 'package:qalgu/views/widgets/common_field.dart';

class UpdateCredentials extends StatelessWidget {
  const UpdateCredentials({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      controller: emailController,
                      image: IconsClass.email,
                      title: 'Email',
                      hintText: 'alice.bob@gmail.com',
                      onChanged: (value) {},
                      validator: (value) {
                        return '';
                      },
                    ),
                    SizedBox(height: Get.height * 0.03),
                    CommonField(
                      isObscure: true,
                      controller: passwordController,
                      image: IconsClass.lock,
                      title: 'Password',
                      hintText: '**********',
                      onChanged: (value) {},
                      validator: (value) {
                        return '';
                      },
                    ),
                    SizedBox(height: Get.height * 0.04),
                    CommonButton(
                      onTap: () {},
                      title: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
