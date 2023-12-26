import 'package:cloud_firestore/cloud_firestore.dart';

class SleepTrackModel {
  String? id;
  String? childId;
  String? date;
  String? startSleep;
  String? endSleep;
  String? sleepDuration;
  String? sleepType;

  SleepTrackModel({
    this.startSleep,
    this.date,
    this.childId,
    this.endSleep,
    this.id,
    this.sleepDuration,
    this.sleepType,
  });

  SleepTrackModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    childId = data.data()!["child_id"] ?? "";
    date = data.data()!['date'] ?? "";
    startSleep = data.data()!["start_sleep"] ?? "";
    endSleep = data.data()!["end_sleep"] ?? "";
    sleepType = data.data()!["sleep_type"] ?? '';
    sleepDuration = data.data()!["sleep_duration"] ?? "";
  }
}
