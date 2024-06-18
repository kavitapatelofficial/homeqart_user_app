import 'package:flutter/material.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/screens/main_screen.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class Body extends StatelessWidget {
  final String message;
  final String odrId;
  const Body({Key? key, required this.message, required this.odrId})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/images/success.png",
              height: MediaQuery.of(context).size.height * 0.4, //40%
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(message, style: Texttheme.heading),
        const SizedBox(
          height: 10,
        ),
        Text("ODR$odrId", style: Texttheme.title),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
            buttonText: "Back to home",
            press: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) {
                  return const MainScreen();
                },
              ), (Route<dynamic> route) => false);
            },
            buttonColor: AppColor.primaryColor,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
