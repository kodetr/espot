import 'package:espot/models/user_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with CacheManager {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  void initState() {
    removeAll();
    super.initState();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
            bottom: 80,
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
          'Sign In Espot',
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
              // NOTE: EMAIL INPUT
              CustomFormField(
                title: 'Email',
                controller: emailController,
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
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(context, '/reset-password');
                  },
                  child: Text(
                    'Forgot Password',
                    style: redTextStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomFilledButton(
                title: 'Sign In',
                onPressed: () async {
                  EasyLoading.show(status: 'loading...');

                  User? user = await signInWithEmailAndPassword(
                      emailController.text, passwordController.text);

                  if (user != null) {
                    try {
                      String uid = user.uid;
                      DatabaseReference usersRef = FirebaseDatabase.instance
                          .ref()
                          .child(USERS)
                          .child(uid);

                      usersRef.once().then((DatabaseEvent event) {
                        if (event.snapshot.value != null) {
                          Map<dynamic, dynamic> userData =
                              event.snapshot.value as Map<dynamic, dynamic>;

                          setState(() {
                            UserModel user = UserModel.fromMap(userData, uid);

                            saveUser(user);
                          });
                          EasyLoading.dismiss();
                        }
                      });
                    } catch (e) {
                      print(e);
                    }
                    setState(() {});
                    Navigator.pushNamed(context, '/home');
                    EasyLoading.dismiss();
                  } else {
                    CustomSnackBar.showToast(context, 'Login Gagal!');
                    EasyLoading.dismiss();
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomTextButton(
          title: 'Create New Account',
          onPressed: () {
            Navigator.pushNamed(context, '/sign-up');
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
