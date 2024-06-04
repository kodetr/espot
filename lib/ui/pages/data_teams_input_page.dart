import 'dart:io';

import 'package:espot/models/teams_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class DataTeamsInputPage extends StatefulWidget {
  final TeamsModel? data;
  const DataTeamsInputPage({
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<DataTeamsInputPage> createState() => _DataTeamsInputPageState();
}

class _DataTeamsInputPageState extends State<DataTeamsInputPage>
    with CacheManager {
  final descController = TextEditingController(text: '');
  final player1Controller = TextEditingController(text: '');
  final player2Controller = TextEditingController(text: '');
  final player3Controller = TextEditingController(text: '');
  final player4Controller = TextEditingController(text: '');
  final player5Controller = TextEditingController(text: '');

  XFile? selectedImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    getLoadUpdate();
  }

  bool validate() {
    if (descController.text.isEmpty ||
        player1Controller.text.isEmpty ||
        player2Controller.text.isEmpty ||
        player3Controller.text.isEmpty ||
        player4Controller.text.isEmpty ||
        player5Controller.text.isEmpty) {
      return false;
    }
    return true;
  }

  void getLoadUpdate() {
    if (widget.data != null) {
      descController.text = widget.data!.desc!;
      player1Controller.text = widget.data!.player1!;
      player2Controller.text = widget.data!.player2!;
      player3Controller.text = widget.data!.player3!;
      player4Controller.text = widget.data!.player4!;
      player5Controller.text = widget.data!.player5!;
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

  Future<void> _addEvent(
    String desc,
    String player1,
    String player2,
    String player3,
    String player4,
    String player5,
  ) async {
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
          FirebaseDatabase.instance.ref().child(TEAMS).child(uid);
      return ref.set({
        'desc': desc,
        'player1': player1,
        'player2': player2,
        'player3': player3,
        'player4': player4,
        'player5': player5,
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

  Future<void> updateData(
    String desc,
    String player1,
    String player2,
    String player3,
    String player4,
    String player5,
  ) async {
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
            FirebaseDatabase.instance.ref().child(TEAMS).child(uid);
        await userRef.once();
        await userRef.update({
          'desc': desc,
          'player1': player1,
          'player2': player2,
          'player3': player3,
          'player4': player4,
          'player5': player5,
          'image': downloadUrl,
        });
        Navigator.pushNamed(context, '/data-success-update');
      } catch (e) {
        print('Error: $e');

        CustomSnackBar.showToast(context, 'Failed to upload image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.data != null ? 'Update Teams' : 'Input Teams',
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
                borderRadius: BorderRadius.circular(20),
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
                    title: 'Player 1',
                    controller: player1Controller,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Player 2',
                    controller: player2Controller,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Player 3',
                    controller: player3Controller,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Player 4',
                    controller: player4Controller,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Player 5',
                    controller: player5Controller,
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
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (validate()) {
                        // TODO CREATE
                        if (widget.data == null) {
                          EasyLoading.show(status: 'loading...');
                          _addEvent(
                            descController.text,
                            player1Controller.text,
                            player2Controller.text,
                            player3Controller.text,
                            player4Controller.text,
                            player5Controller.text,
                          );
                          EasyLoading.dismiss();
                          // TODO UPDATE
                        } else {
                          EasyLoading.show(status: 'loading...');
                          updateData(
                            descController.text,
                            player1Controller.text,
                            player2Controller.text,
                            player3Controller.text,
                            player4Controller.text,
                            player5Controller.text,
                          );
                          EasyLoading.dismiss();
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
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
