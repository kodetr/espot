import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? uid;
  String? name;
  String? phone;
  String? email;
  String? password;
  bool? verified;
  String? profilePicture;

  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.verified,
    this.profilePicture,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] as String?,
      phone: data['phone'] as String?,
      email: data['email'] as String?,
      verified: data['verified'] as bool?,
      profilePicture: data['profilePicture'] as String?,
    );
  }
}
