import 'package:flutter/material.dart';
import 'package:homeqartapp/screens/sign_up/sign_up_screen.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: Texttheme.subTitle,
        ),
        GestureDetector(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SignUpScreen();
          })),
          child: Text("Sign Up",
              style: Texttheme.subTitle.copyWith(color: AppColor.primaryColor)),
        ),
      ],
    );
  }
}
