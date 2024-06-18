import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';

import '../../theme.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Sign In"),
      body: const Body(),
    );
  }
}
