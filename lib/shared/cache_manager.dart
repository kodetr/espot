import 'package:espot/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin CacheManager {
  Future<bool> saveUser(UserModel? response) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ID.toString(), response!.uid);
    await box.write(CacheManagerKey.NAME.toString(), response.name);
    await box.write(CacheManagerKey.PHONE.toString(), response.phone);
    await box.write(CacheManagerKey.EMAIL.toString(), response.email);
    await box.write(CacheManagerKey.PHOTO.toString(), response.profilePicture);
    return true;
  }

  Future<bool> savePhoto(String? url) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.PHOTO.toString(), url);
    return true;
  }

  String? getId() {
    final box = GetStorage();
    return box.read(CacheManagerKey.ID.toString()) ?? '';
  }

  String? getName() {
    final box = GetStorage();
    return box.read(CacheManagerKey.NAME.toString()) ?? 'Admin';
  }

  String? getPHONE() {
    final box = GetStorage();
    return box.read(CacheManagerKey.PHONE.toString()) ?? '-';
  }

  String? getEmail() {
    final box = GetStorage();
    return box.read(CacheManagerKey.EMAIL.toString()) ?? 'admin@gmail.com';
  }

  String? getPhoto() {
    final box = GetStorage();
    return box.read(CacheManagerKey.PHOTO.toString()) ?? '';
  }

  // String? getToken() {
  //   final box = GetStorage();
  //   return box.read(CacheManagerKey.TOKEN.toString());
  // }

  Future<void> removeAll() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.ID.toString());
    await box.remove(CacheManagerKey.NAME.toString());
    await box.remove(CacheManagerKey.PHONE.toString());
    await box.remove(CacheManagerKey.EMAIL.toString());
    await box.remove(CacheManagerKey.PHOTO.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { ID, NAME, PHONE, EMAIL, PHOTO }
