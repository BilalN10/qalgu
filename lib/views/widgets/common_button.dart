import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  CommonButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isWhiteButton = false,
    this.isBorderEnalbe = false,
  });
  final VoidCallback onTap;
  final String title;
  bool isWhiteButton;
  bool isBorderEnalbe;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: Get.height * 0.065,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(isWhiteButton ? 18.0 : 16.0),
                    side: BorderSide(
                        color: isBorderEnalbe
                            ? ColorsClass.primaryColor
                            : Colors.transparent)),
              ),
              backgroundColor: MaterialStateProperty.all(
                  isWhiteButton ? Colors.white : ColorsClass.primaryColor)),
          onPressed: onTap,
          child: Text(
            title,
            style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isWhiteButton ? ColorsClass.primaryColor : Colors.white),
          )),
    );
  }
}
