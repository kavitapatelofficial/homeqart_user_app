import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class CustomStatusContainer extends StatelessWidget {
  final String buttonText;
  final String statusHeading;
  final String description;
  final String imageUrl;
  final VoidCallback press;
  const CustomStatusContainer({
    Key? key,
    required this.buttonText,
    required this.description,
    required this.imageUrl,
    required this.statusHeading,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: AppColor.accentWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SvgPicture.asset(
                imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    statusHeading,
                    style: Texttheme.heading,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: Texttheme.bodyText1
                        .copyWith(color: AppColor.neturalBrown),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: DefaultButton(
                        buttonText: buttonText,
                        press: press,
                        buttonColor: AppColor.primaryColor),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
