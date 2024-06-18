import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  final String message;
  final String odrId;
  const LoginSuccessScreen({
    Key? key,
    required this.message,
    required this.odrId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Order Status"),
      body: Body(
        message: message,
        odrId: odrId,
      ),
    );
  }
}
