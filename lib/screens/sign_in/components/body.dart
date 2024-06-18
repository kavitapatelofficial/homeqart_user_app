import 'package:flutter/material.dart';
import 'package:homeqartapp/components/no_account_text.dart';
import 'package:homeqartapp/text_theme.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .15),
                Text("Welcome Back", style: Texttheme.heading),
                const SizedBox(height: 15),
                Text(
                  "Sign in with your phone number and password",
                  style: Texttheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const SignForm(),
                const SizedBox(height: 10),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
