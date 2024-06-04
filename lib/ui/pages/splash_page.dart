import 'dart:async';

import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              color: bgColor,
              image: const DecorationImage(
                image: AssetImage(
                  'assets/img_espot.png',
                ),
              )),
        ),
      ),
    );
  }
}
