import 'package:firebase_database/firebase_database.dart';

class EventModel {
  String? uid;
  String? desc;
  String? image;

  EventModel({
    this.uid,
    this.desc,
    this.image,
  });

  factory EventModel.fromMap(Map<dynamic, dynamic> data, String uid) {
    return EventModel(
      uid: uid,
      desc: data['desc'] as String?,
      image: data['image'] as String?,
    );
  }
}
