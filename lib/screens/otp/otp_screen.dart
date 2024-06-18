import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  final String mobileNUmber;
  final String userId;

  const OtpScreen({Key? key, required this.mobileNUmber, required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("OTP Verification"),
      body: Body(
        mobileNUmber: mobileNUmber,
        userId: userId,
      ),
    );
  }
}
