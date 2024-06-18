import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/custom_status_container.dart';
import 'package:homeqartapp/theme.dart';

class StatusScreen extends StatelessWidget {
  final String title;
  final String buttonText;
  final String statusHeading;
  final String description;
  final String imageUrl;
  final VoidCallback press;
  const StatusScreen(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.description,
      required this.imageUrl,
      required this.press,
      required this.statusHeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar(title),
      body: SafeArea(
          child: Center(
        child: CustomStatusContainer(
          buttonText: buttonText,
          description: description,
          imageUrl: imageUrl,
          press: press,
          statusHeading: statusHeading,
        ),
      )),
    );
  }
}
