import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalgu/controllers/manage_chilld_controller.dart';
import 'package:qalgu/views/root/tabs/sleep/components/baby_info_tile.dart';

class SleepHeader extends StatelessWidget {
  const SleepHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetX<ManageChildController>(
          init: Get.put(ManageChildController()),
          builder: (cont) {
            return Row(
              children: List.generate(cont.getBabylist.length, (index) {
                return BabyInfoTile(babyModel: cont.getBabylist[index]);
              }),
            );
          }),
    );
  }
}
