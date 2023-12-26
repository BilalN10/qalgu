import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';

// ignore: must_be_immutable
class CommonField extends StatelessWidget {
  CommonField({
    super.key,
    required this.controller,
    required this.image,
    required this.title,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.isObscure = false,
  });

  final TextEditingController controller;
  final String image;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(image),
            Text(
              ' $title',
              style: GoogleFonts.dmSans(fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.015),
        TextFormField(
          style: GoogleFonts.dmSans(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          obscureText: isObscure,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.dmSans(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            contentPadding: const EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorsClass.primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorsClass.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorsClass.primaryColor)),
          ),
        ),
      ],
    );
  }
}
