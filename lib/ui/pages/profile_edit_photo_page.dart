import 'dart:convert';
import 'dart:io';
import 'package:espot/models/sign_up_form_model.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPhotoPage extends StatefulWidget {
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
                      // context.read<AuthBloc>().add(
                      //       AuthRegister(
                      //         widget.data.copyWith(
                      //           profilePicture:
                      //               'data:image/png;base64,${base64Encode(File(selectedImage!.path).readAsBytesSync())}',
                      //         ),
                      //       ),
                      // );
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
