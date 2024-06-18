import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/screens/main_screen.dart';
import 'package:homeqartapp/screens/sign_in/sign_in_screen.dart';
import 'package:homeqartapp/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  authenticate() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return box.read("is_logged_in").toString() == "true"
                  ? const MainScreen()
                  : const SignInScreen();
              // const Signin();
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentWhite,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image.asset(
            "assets/images/HomeQart.png",
          ),
        ),
      )),
    );
  }
}
