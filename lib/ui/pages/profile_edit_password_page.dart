import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:espot/models/user_model.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditPasswordPage extends StatefulWidget with CacheManager {
  final UserModel data;

  const ProfileEditPasswordPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditPasswordPage> createState() =>
      _ProfileEditPasswordPageState();
}

class _ProfileEditPasswordPageState extends State<ProfileEditPasswordPage> {
  final passwordOldController = TextEditingController(text: '');
  final passwordNewController = TextEditingController(text: '');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool validate() {
    if (passwordOldController.text.isEmpty ||
        passwordNewController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> _changePassword(String oldPassword, String newPassword) async {
    User user = _auth.currentUser!;

    try {
      // Reauthenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: widget.getEmail()!,
        password: oldPassword,
      );

      user.reauthenticateWithCredential(credential);
      // Update password
      await user.updatePassword(newPassword);
      // print('berhasil');
      Navigator.pushNamed(context, '/profile-update-password-success');
    } catch (e) {
      print('Error: $e');
      CustomSnackBar.showToast(context, 'Gagal mengubah kata sandi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
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
                  CustomFormField(
                    title: 'Old Password',
                    controller: passwordOldController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'New Password',
                    controller: passwordNewController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Update Now',
                    onPressed: () {
                      if (validate()) {
                        String oldPassword = passwordOldController.text;
                        String newPassword = passwordNewController.text.trim();

                        _changePassword(oldPassword, newPassword);
                        print('tekan');
                        // CustomSnackBar.showToast(context,
                        //     'The old and new passwords are not the same');
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
