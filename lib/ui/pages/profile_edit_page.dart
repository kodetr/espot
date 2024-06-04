import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:espot/models/user_model.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditPage extends StatefulWidget with CacheManager {
  final UserModel data;

  const ProfileEditPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final phoneController = TextEditingController(text: '');

  @override
  void initState() {
    getLoadUpdate();
    super.initState();
  }

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return false;
    }

    return true;
  }

  void getLoadUpdate() {
    if (widget.getId() != null) {
      nameController.text = widget.getName()!;
      emailController.text = widget.getEmail()!;
      phoneController.text = widget.getPHONE()!;
    }
  }

  Future<void> updateData(String name, String email, String phone) async {
    if (widget.getId() != null) {
      String uid = widget.getId()!;

      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child(USERS).child(uid);
      DatabaseEvent event = await userRef.once();

      if (event.snapshot.value != null) {
        String currentEmail =
            (event.snapshot.value as Map<dynamic, dynamic>)['email'];

        // Masuk kembali dengan email dan password lama pengguna
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: currentEmail,
          password: PASSWORDDEFAULT,
        );

        // Perbarui email pengguna di Firebase Authentication
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.verifyBeforeUpdateEmail(email);
          // Perbarui data pengguna di Realtime Database
          await userRef.update({
            'name': name,
            'email': email,
            'phone': phone,
            'verified': false,
          });
          Navigator.pushNamed(context, '/profile-update-success');
        } else {
          CustomSnackBar.showToast(context, 'Email sudah terdaftar');
        }
      }
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
                    title: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Phone',
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Update Now',
                    onPressed: () {
                      if (validate()) {
                        updateData(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                        );
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
