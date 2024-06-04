import 'package:espot/ui/pages/data_event_page.dart';
import 'package:espot/ui/pages/data_events_input_page.dart';
import 'package:espot/ui/pages/data_success_delete_page.dart';
import 'package:espot/ui/pages/data_success_update_page.dart';
import 'package:espot/ui/pages/data_teams_input_page.dart';
import 'package:espot/ui/pages/data_teams_page.dart';
import 'package:espot/ui/pages/profile_edit_password_success_page.dart';
import 'package:espot/ui/pages/profile_edit_photo_success_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/pages/data_success_page.dart';
import 'package:espot/ui/pages/data_users_page.dart';
import 'package:espot/ui/pages/home_page.dart';
import 'package:espot/ui/pages/data_users_input_page.dart';
import 'package:espot/ui/pages/onboarding_page.dart';
import 'package:espot/ui/pages/profile_edit_success_page.dart';
import 'package:espot/ui/pages/profile_page.dart';
import 'package:espot/ui/pages/reset_password.dart';
import 'package:espot/ui/pages/sign_in_page.dart';
import 'package:espot/ui/pages/sign_up_page.dart';
import 'package:espot/ui/pages/reset_password_success_page.dart';
import 'package:espot/ui/pages/sign_up_success_page%20copy.dart';
import 'package:espot/ui/pages/splash_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: blackColor,
          ),
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/sign-up-success': (context) => const SignUpSuccessPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/reset-password-success': (context) =>
            const ResetPasswordSuccessPage(),
        '/home': (context) => const HomePage(),
        '/users': (context) => const DataUsersPage(),
        '/user-input': (context) => const DataUsersInputPage(),
        '/data-success': (context) => const DataSuccessPage(),
        '/data-success-update': (context) => const DataSuccessUpdatePage(),
        '/data-success-delete': (context) => const DataSuccessDeletePage(),
        '/profile': (context) => const ProfilePage(),
        '/profile-update-success': (context) => const ProfileEditSuccessPage(),
        '/profile-update_photo-success': (context) =>
            const ProfileEditPhotoSuccessPage(),
        '/profile-update-password-success': (context) =>
            const ProfileEditPasswordSuccessPage(),
        '/event': (context) => const DataEventPage(),
        '/event-input': (context) => const DataEventInputPage(),
        '/teams': (context) => const DataTeamsPage(),
        '/teams-input': (context) => const DataTeamsInputPage()
      },
    );
  }
}
