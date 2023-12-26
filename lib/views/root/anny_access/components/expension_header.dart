import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';

class ExpansionHeader extends StatelessWidget {
  const ExpansionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Skylar Kenter ',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: ColorsClass.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Skylar Kenter ',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff545454),
              ),
            ),
            const Spacer(),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff6BB5F6),
                    Color(0xff52A3EB),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  IconsClass.edit,
                  height: 10,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff6BB5F6),
                    Color(0xff52A3EB),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  IconsClass.trash,
                  height: 10,
                ),
              ),
            ),
          ],
        ),
        Text(
          'Has limited nanny access',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff545454),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(IconsClass.email),
            const SizedBox(width: 5),
            Text(
              'skylar.kenter@gmail.com',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xff545454),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: ColorsClass.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(IconsClass.call),
            const SizedBox(width: 5),
            Text(
              '554-334-5546',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xff545454),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
