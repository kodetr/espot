import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final phoneController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

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
            'Reset Password',
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
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Send',
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset-password-success');
                    // context.read<AuthBloc>().add(
                    //       AuthLogin(
                    //         SignInFormModel(
                    //           phoneNumber: phoneController.text,
                    //           password: passwordController.text,
                    //         ),
                    //       ),
                    //     );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Masukan Email yang Terdaftar\nuntuk mendapatkan password Baru',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 15,
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
