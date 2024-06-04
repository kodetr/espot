import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final phoneNumberController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    print(nameController.text);

    if (nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> addUser(String uid, String name, String email, String phone) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child(USERS).child(uid);
    return ref.set({
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': '',
      'verified': false,
    }).then((value) {
      print("User Added");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
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
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          Container(
            width: 180,
            height: 180,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 50,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/img_logo_light.png',
                ),
              ),
            ),
          ),
          Text(
            'Join Us to Espot',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
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
                // NOTE: NAME INPUT
                CustomFormField(
                  title: 'Full Name',
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
                // NOTE: EMAIL INPUT
                CustomFormField(
                  title: 'Phone Number',
                  controller: phoneNumberController,
                ),
                const SizedBox(
                  height: 16,
                ),
                // NOTE: PASSWORD INPUT
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 30,
                ),

                CustomFilledButton(
                  title: 'Continue',
                  onPressed: () async {
                    EasyLoading.show(status: 'loading...');
                    User? user = await signUpWithEmailAndPassword(
                        nameController.text,
                        emailController.text,
                        phoneNumberController.text,
                        passwordController.text);

                    if (user != null) {
                      Navigator.pushNamed(context, '/sign-up-success');
                    } else {
                      CustomSnackBar.showToast(
                          context, 'Email sudah terdaftar');
                    }
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextButton(
            title: 'Sign In',
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
