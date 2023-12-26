// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/models/inbox_model.dart';
import 'package:qalgu/views/root/tabs/inbox/inbox_detail_page.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: inboxList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => InboxDetailPage(
                            inboxData: inboxList[index],
                          )),
                      child: Container(
                        width: Get.width,
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                child: SvgPicture.asset(
                                  IconsClass.inbox,
                                  color: ColorsClass.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(
                                inboxList[index].message,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.dmSans(
                                  color: const Color(0xff1f1f1f),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    inboxList[index].isUnread
                        ? const Positioned(
                            right: 15,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xffFA3DA1),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
