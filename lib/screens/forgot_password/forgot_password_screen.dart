import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Forgot Password"),
      body: const Body(),
    );
  }
}
