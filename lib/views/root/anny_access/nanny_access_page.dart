// ignore_for_file: deprecated_member_use

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/root/tabs/setting/components/setting_appbar.dart';
import 'package:qalgu/views/widgets/common_field.dart';

import 'components/expension_header.dart';

class NannyAccessPage extends StatefulWidget {
  const NannyAccessPage({super.key});

  @override
  State<NannyAccessPage> createState() => _NannyAccessPageState();
}

class _NannyAccessPageState extends State<NannyAccessPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsClass.primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                ),
                Positioned(
                    top: 0,
                    left: -100,
                    child: Image.asset(
                      'assets/images/root_header.png',
                      fit: BoxFit.cover,
                      width: Get.width,
                    )),
                Positioned(
                    top: Get.height * 0.06,
                    left: 0,
                    child: SvgPicture.asset(IconsClass.cloud)),
                Positioned(
                  bottom: Get.height * 0.006,
                  right: -Get.width * 0.05,
                  child: SvgPicture.asset(
                    IconsClass.footer,
                    color: Colors.white.withOpacity(.2),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.05,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingAppbar(
                          title: 'Manage Member Access', isQuestion: true),
                      SizedBox(
                        height: Get.height * 0.9,
                        width: Get.width,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionWidget(
                                  initiallyExpanded: false,
                                  titleBuilder: (double animationValue, _,
                                      bool isExpaned, toogleFunction) {
                                    return InkWell(
                                      onTap: () =>
                                          toogleFunction(animated: true),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(.5),
                                              borderRadius: isExpaned
                                                  ? const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                    )
                                                  : BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.all(8),
                                            child: const ExpansionHeader()),
                                      ),
                                    );
                                  },
                                  content: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.5),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        )),
                                    child: Column(
                                      children: [
                                        const Divider(),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: CommonField(
                                                controller: emailController,
                                                image: IconsClass.email,
                                                title: 'Update Email',
                                                hintText:
                                                    'skylar.kenter@gmail.com',
                                                onChanged: (value) {},
                                                validator: (value) {
                                                  return '';
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: ColorsClass
                                                        .primaryColor),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.done,
                                                  size: 30,
                                                  color:
                                                      ColorsClass.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: CommonField(
                                                controller: emailController,
                                                image: IconsClass.call,
                                                title: 'Update Phone Number',
                                                hintText: '554-334-5546',
                                                onChanged: (value) {},
                                                validator: (value) {
                                                  return '';
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: ColorsClass
                                                        .primaryColor),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.done,
                                                  size: 30,
                                                  color:
                                                      ColorsClass.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      // ExpandedTileList.builder(
                      //   itemCount: 10,
                      //   maxOpened: 1,
                      //   itemBuilder: (context, index, controller) {
                      //     return ExpandedTile(
                      //       contentseparator: 0,
                      //       theme: ExpandedTileThemeData(
                      //         titlePadding: EdgeInsets.zero,
                      //         trailingPadding: EdgeInsets.zero,
                      //         leadingPadding: EdgeInsets.zero,
                      //         headerColor: Colors.white.withOpacity(.5),
                      //         headerRadius: 16.0,
                      //         headerSplashColor: Colors.grey.shade300,
                      //         contentBackgroundColor:
                      //             Colors.white.withOpacity(.5),
                      //         contentPadding:
                      //             const EdgeInsets.only(bottom: 8.0),
                      //         contentRadius: 0.0,
                      //       ),
                      //       controller: controller,
                      //       trailing: null,
                      //       title: const ExpansionHeader(),
                      //       content: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           children: [
                      //             const Divider(
                      //               color: Color(0xffC7E0F5),
                      //               thickness: 1.5,
                      //             ),
                      //             Container(
                      //               width: Get.width * 0.9,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white.withOpacity(.5),
                      //                 borderRadius: BorderRadius.circular(12),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(12.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       onTap: () {},
                      //       onLongTap: () {},
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
