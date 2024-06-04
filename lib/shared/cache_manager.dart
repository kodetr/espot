import 'package:espot/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin CacheManager {
  // Future<bool> saveToken(User? response) async {
  //   final box = GetStorage();
  //   await box.write(CacheManagerKey.ID.toString(), response!.uid);
  //   await box.write(CacheManagerKey.NAME.toString(), response.displayName);
  //   await box.write(CacheManagerKey.PHONE.toString(), response.phoneNumber);
  //   await box.write(CacheManagerKey.EMAIL.toString(), response.email);
  //   // await box.write(CacheManagerKey.TOKEN.toString(), response.getIdToken());
  //   return true;
  // }

  Future<bool> saveUser(UserModel? response) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ID.toString(), response!.uid);
    await box.write(CacheManagerKey.NAME.toString(), response.name);
    await box.write(CacheManagerKey.PHONE.toString(), response.phone);
    await box.write(CacheManagerKey.EMAIL.toString(), response.email);
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
    // await box.remove(CacheManagerKey.TOKEN.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { ID, NAME, PHONE, EMAIL, TOKEN, V }
