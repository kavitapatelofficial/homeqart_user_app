import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class DefaultButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback press;
  final Color buttonColor;
  const DefaultButton(
      {Key? key,
      required this.buttonText,
      required this.press,
      required this.buttonColor})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.press,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: widget.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // <-- Radius
          ),
        ),
        child: Text(
          widget.buttonText,
          style: Texttheme.title.copyWith(color: AppColor.accentWhite),
        ),
      ),
    );
  }
}
