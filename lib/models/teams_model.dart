import 'package:firebase_database/firebase_database.dart';

class TeamsModel {
  String? uid;
  String? desc;
  String? player1;
  String? player2;
  String? player3;
  String? player4;
  String? player5;
  String? image;

  TeamsModel({
    this.uid,
    this.desc,
    this.player1,
    this.player2,
    this.player3,
    this.player4,
    this.player5,
    this.image,
  });

  factory TeamsModel.fromMap(Map<dynamic, dynamic> data, String uid) {
    return TeamsModel(
      uid: uid,
      desc: data['desc'] as String?,
      player1: data['player1'] as String?,
      player2: data['player2'] as String?,
      player3: data['player3'] as String?,
      player4: data['player4'] as String?,
      player5: data['player5'] as String?,
      image: data['image'] as String?,
    );
  }
}
