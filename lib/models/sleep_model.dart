import 'package:flutter/material.dart';

class SleepModel {
  String startTime;
  String endTime;
  IconData icon;
  String title;
  String subtitle;
  bool isStopRecord;
  SleepModel({
    required this.startTime,
    required this.endTime,
    required this.icon,
    this.isStopRecord = false,
    required this.subtitle,
    required this.title,
  });
}

List<SleepModel> sleepList = [
  SleepModel(
    startTime: '7:40',
    endTime: '14:05',
    icon: Icons.light_mode_outlined,
    subtitle: '2 hour, 5 minutes',
    title: 'Day sleep',
  ),
  SleepModel(
    startTime: '19:40',
    endTime: '23:05',
    icon: Icons.dark_mode_outlined,
    subtitle: '2 hour, 5 minutes',
    title: 'Day sleep',
  ),
  SleepModel(
    startTime: '19:40',
    endTime: '23:05',
    isStopRecord: true,
    icon: Icons.dark_mode_outlined,
    subtitle: '2 hour, 5 minutes',
    title: 'Day sleep',
  ),
];
