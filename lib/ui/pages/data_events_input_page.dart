import 'dart:io';

import 'package:espot/models/event_model.dart';
import 'package:espot/models/user_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class DataEventInputPage extends StatefulWidget {
  final EventModel? data;
  const DataEventInputPage({
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<DataEventInputPage> createState() => _DataEventInputPageState();
}

class _DataEventInputPageState extends State<DataEventInputPage>
    with CacheManager {
  final descController = TextEditingController(text: '');

  XFile? selectedImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Future<void> addEvent(String uid, String desc, String img) {
  //   DatabaseReference ref =
  //       FirebaseDatabase.instance.ref().child(EVENTS).child(uid);
  //   return ref.set({
  //     'desc': desc,
  //     'image': img,
  //   }).then((value) {
  //     Navigator.pushNamed(context, '/data-success');
  //     print("Event Added");
  //   }).catchError((error) => print("Failed to add Event: $error"));
  // }

  @override
  void initState() {
    super.initState();
    getLoadUpdate();
  }

  bool validate() {
    if (descController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void getLoadUpdate() {
    if (widget.data != null) {
      descController.text = widget.data!.desc!;
    }
  }

  selectImage() async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> updateData(String desc) async {
    if (selectedImage == null) return;
    if (widget.data != null) {
      try {
        String uid = widget.data!.uid!;
        String fileName =
            'uploads/${DateTime.now().millisecondsSinceEpoch}.png';
        File file = File(selectedImage!.path);
        UploadTask uploadTask = _storage.ref().child(fileName).putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child(EVENTS).child(uid);
        await userRef.once();
        await userRef.update({
          'desc': desc,
          'image': downloadUrl,
        });
        Navigator.pushNamed(context, '/data-success-update');
      } catch (e) {
        print('Error: $e');

        CustomSnackBar.showToast(context, 'Failed to upload image');
      }
    }
  }

  Future<void> _addEvent(String desc) async {
    if (selectedImage == null) return;

    try {
      String fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}.png';
      File file = File(selectedImage!.path);
      UploadTask uploadTask = _storage.ref().child(fileName).putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      const Uuid uuid = Uuid();
      String uid = uuid.v4();

      // updateDataPhoto(downloadUrl);
      print(downloadUrl);

      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child(EVENTS).child(uid);
      return ref.set({
        'desc': desc,
        'image': downloadUrl,
      }).then((value) {
        Navigator.pushNamed(context, '/data-success');
        print("Event Added");
      }).catchError((error) => print("Failed to add Event: $error"));
    } catch (e) {
      print('Error: $e');

      CustomSnackBar.showToast(context, 'Failed to upload image');
    }
  }

  // Future<void> updateDataPhoto(String photo) async {
  //   if (widget.getId() != null) {
  //     String uid = widget.getId()!;

  //     DatabaseReference userRef =
  //         FirebaseDatabase.instance.ref().child(USERS).child(uid);
  //     DatabaseEvent event = await userRef.once();

  //     if (event.snapshot.value != null) {
  //       await userRef.update({
  //         'profilePicture': photo,
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.data != null ? 'Update Events' : 'Input Events',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: Container(
                        width: 500,
                        height: 180,
                        decoration: BoxDecoration(
                          color: lightBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          image: selectedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(
                                    File(
                                      selectedImage!.path,
                                    ),
                                  ),
                                ),
                        ),
                        child: selectedImage != null
                            ? null
                            : Center(
                                child: Image.asset(
                                  'assets/ic_upload.png',
                                  width: 32,
                                ),
                              )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Description',
                    maxLine: 5,
                    controller: descController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (validate()) {
                        // TODO CREATE
                        if (widget.data == null) {
                          _addEvent(descController.text);
                          // TODO UPDATE
                        } else {
                          updateData(descController.text);
                        }
                      } else {
                        CustomSnackBar.showToast(
                            context, 'Inputan masih kosong');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
