import 'package:espot/models/user_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DataUsersInputPage extends StatefulWidget {
  final UserModel? dataUser;
  const DataUsersInputPage({
    this.dataUser,
    Key? key,
  }) : super(key: key);

  @override
  State<DataUsersInputPage> createState() => _DataUsersInputPageState();
}

class _DataUsersInputPageState extends State<DataUsersInputPage>
    with CacheManager {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final phoneController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> addUser(String uid, String name, String email, String phone) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child(USERS).child(uid);
    return ref
        .set({
          'name': name,
          'email': email,
          'phone': phone,
          'profilePicture': '',
          'verified': false,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
      EasyLoading.show(status: 'loading...');
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        await addUser(user!.uid, name, email, phone);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      EasyLoading.dismiss();
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getLoadUpdate();
  }

  void getLoadUpdate() {
    if (widget.dataUser != null) {
      nameController.text = widget.dataUser!.name!;
      emailController.text = widget.dataUser!.email!;
      phoneController.text = widget.dataUser!.phone!;
    }
  }

  Future<void> updateData(String name, String email, String phone) async {
    if (widget.dataUser != null) {
      String uid = widget.dataUser!.uid!;

      try {
        EasyLoading.show(status: 'loading...');
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
            Navigator.pushNamed(context, '/data-success-update');
            EasyLoading.dismiss();
          } else {
            CustomSnackBar.showToast(context, 'Email sudah terdaftar');
            EasyLoading.dismiss();
          }
        }
      } catch (e) {
        print(e);
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.dataUser != null ? 'Update User' : 'Input User',
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
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (validate()) {
                        // TODO CREATE
                        if (widget.dataUser == null) {
                          User? user = await signUpWithEmailAndPassword(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            PASSWORDDEFAULT,
                          );

                          if (user != null) {
                            Navigator.pushNamed(context, '/data-success');
                            EasyLoading.dismiss();
                          } else {
                            CustomSnackBar.showToast(
                                context, 'Email sudah terdaftar');
                            EasyLoading.dismiss();
                          }

                          // TODO UPDATE
                        } else {
                          updateData(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                          );
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
