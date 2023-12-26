import 'package:cloud_firestore/cloud_firestore.dart';

class BabyModel {
  String? babyId;
  String? babyName;
  String? babyImage;
  String? babyDob;
  bool? sleepTrackOn;

  BabyModel({this.babyDob, this.babyImage, this.babyName, this.sleepTrackOn});

  BabyModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    babyId = data.id;
    babyName = data.data()!["baby_name"] ?? "";
    babyImage = data.data()!['baby_image'] ?? "";
    babyDob = data.data()!["dob"] ?? "";
    sleepTrackOn = data.data()!['sleep_track_on'];
  }
}
