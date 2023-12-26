// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/controllers/manage_sleep_controller.dart';

import 'echarts.dart';

// ignore: constant_identifier_names
enum StatsMode { Weekly, Monthly, Yearly }

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  StatsMode selectedMode = StatsMode.Monthly;

  void changeMode(StatsMode newMode) {
    setState(() {
      selectedMode = newMode;
    });
  }

  String getModeText(StatsMode mode) {
    switch (mode) {
      case StatsMode.Weekly:
        return 'Weekly';
      case StatsMode.Monthly:
        return 'Monthly';
      case StatsMode.Yearly:
        return 'Yearly';
    }
  }

  ManageSleepController manageSleepController =
      Get.put(ManageSleepController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        changeMode(StatsMode.values[(selectedMode.index - 1) %
                            StatsMode.values.length]);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(IconsClass.arrowLeft),
                        ),
                      ),
                    ),
                    Text(
                      getModeText(selectedMode),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeMode(StatsMode.values[(selectedMode.index + 1) %
                            StatsMode.values.length]);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(IconsClass.arrowRight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Night Sleep',
                  style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Monthly Average: ',
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: '6h:23m',
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  // height: 255,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Get.width * 0.95,
                          height: 239,
                          child: GetX<ManageSleepController>(
                              init: manageSleepController,
                              builder: (cont) {
                                return Echarts(
                                  captureAllGestures: true,
                                  option: '''
                            {
                                    dataset: {
                                      dimensions: ['name', 'value'],
                                      source: ${jsonEncode(cont.getdurationList)},
                                        },
                                        color: ['#ffffff'],
                                        legend: {
                                          data: ['直接访问', '背景'],
                                          show: true,
                                        },
                                        grid: {
                                          left: '0%',
                                          right: '0%',
                                          bottom: '5%',
                                          top: '7%',
                                          height: '85%',
                                          containLabel: true,
                                          z: 22,
                                        },
                                        xAxis: [{
                                          type: 'category',
                                          gridIndex: 0,
                                          axisTick: {
                                            show: false,
                                          },
                                          axisLine: {
                                            lineStyle: {
                                                      color: '#6BB5F6',
                                            },
                                          },
                                          axisLabel: {
                                            show: true,
                                            color: '0xff6BB5F6',
                                            formatter: function xFormatter(value, index) {
                                                      if (index === 6) {
                              return `\${value}\\n*`;
                                                      }
                                                      return value;
                                            },
                                          },
                                        }],
                                        yAxis: {
                                          type: 'value',
                                          gridIndex: 0,
                                          splitLine: {
                                            show: false,
                                          },
                                          axisTick: {
                                                      show: false,
                                          },
                                          axisLine: {
                                            lineStyle: {
                                                      color: '#6BB5F6',
                                            },
                                          },
                                          axisLabel: {
                                            color: 'rgb(170,170,170)',
                                          },
                                          splitNumber: 12,
                                          splitArea: {
                                            show: true,
                                            areaStyle: {
                                                      color: ['rgba(250,250,250,0.0)', 'rgba(250,250,250,0.05)'],
                                            },
                                          },
                                        },
                                        series: [{
                                          name: '合格率',
                                          type: 'bar',
                                          barWidth: '50%',
                                          xAxisIndex: 0,
                                          yAxisIndex: 0,
                                          itemStyle: {
                                            normal: {
                                                      barBorderRadius: 5,
                                                      color: {
                              type: 'linear',
                              x: 0,
                              y: 0,
                              x2: 0,
                              y2: 1,
                              colorStops: [
                                {
                                  offset: 0, color: '#6BB5F6',
                                },
                                {
                                  offset: 1, color: '#6BB5F6',
                                },
                                {
                                  offset: 1, color: '#6BB5F6',
                                },
                              ],
                                                      },
                                            },
                                          },
                                          zlevel: 11,
                                        }],
                                }
                              ''',
                                  extraScript: '''
                                chart.on('click', (params) => {
                                        if(params.componentType === 'series') {
                                          Messager.postMessage(JSON.stringify({
                                            type: 'select',
                                            payload: params.dataIndex,
                                          }));
                                        }
                                });
                              ''',
                                  onMessage: (String message) {
                                    // Map<String, Object> messageAction = jsonDecode(message);
                                    // print(messageAction);
                                    // if (messageAction['type'] == 'select') {
                                    //   final item = _data1[messageAction['payload']];
                                    //   _scaffoldKey.currentState.showSnackBar(
                                    //     SnackBar(
                                    //       content: Text(item['name'].toString() + ': ' + display(item['value'])),
                                    //       duration: Duration(seconds: 2),
                                    //     ));
                                    // }
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    sleepStatsTab(0, IconsClass.day, 'Day\nSleep'),
                    sleepStatsTab(1, IconsClass.night, 'Night\nSleep'),
                    sleepStatsTab(2, IconsClass.lognest, 'Longest\nSleep'),
                    sleepStatsTab(3, IconsClass.sleep1, 'Total\nSleep'),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sleepStatsTab(int index, String image, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 88,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsClass.primaryColor),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? ColorsClass.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: SvgPicture.asset(
                  image,
                  color: index == selectedIndex
                      ? Colors.white
                      : ColorsClass.primaryColor,
                )),
              ),
            ),
            Text(
              'Day\nSleep',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
