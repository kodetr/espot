import 'dart:convert';
import 'dart:io';
import 'package:espot/models/sign_up_form_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditPhotoPage extends StatefulWidget with CacheManager {
  final SignUpFormModel data;

  const ProfileEditPhotoPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProfileEditPhotoPage> createState() => _ProfileEditPhotoPageState();
}

class _ProfileEditPhotoPageState extends State<ProfileEditPhotoPage> {
  XFile? selectedImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<void> _uploadImage() async {
    if (selectedImage == null) return;

    try {
      String fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}.png';
      File file = File(selectedImage!.path);
      UploadTask uploadTask = _storage.ref().child(fileName).putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      updateDataPhoto(downloadUrl);
      print(downloadUrl);
      widget.savePhoto(downloadUrl);

      Navigator.pushNamed(context, '/data-success');
    } catch (e) {
      print('Error: $e');

      CustomSnackBar.showToast(context, 'Failed to upload image');
    }
  }

  Future<void> updateDataPhoto(String photo) async {
    if (widget.getId() != null) {
      String uid = widget.getId()!;

      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child(USERS).child(uid);
      DatabaseEvent event = await userRef.once();

      if (event.snapshot.value != null) {
        await userRef.update({
          'profilePicture': photo,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Photo',
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
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      image: selectedImage == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
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
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.data.name!,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomFilledButton(
                  title: 'Update Now',
                  onPressed: () {
                    if (selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Gambar tidak boleh kosong',
                          ),
                          backgroundColor: redColor,
                        ),
                      );
                    } else {
                      EasyLoading.show(status: 'loading...');
                      _uploadImage();
                      EasyLoading.dismiss();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
