import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OtpDialogState();
}

class OtpDialogState extends State<OtpDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'We will send an OTP to your Phone Number. Please enter your OTP in below box.',
                      textAlign: TextAlign.center,
                      style: Texttheme.title,
                    ),
                    PinCodeTextField(
                      autofocus: true,
                      hideCharacter: true,
                      highlight: true,
                      // highlightColor: Colors.blue,
                      // defaultBorderColor: AppColor.accentLightGrey,
                      // hasTextBorderColor: AppColor.primaryColor,
                      maxLength: 4,
                      onTextChanged: (text) {
                        setState(() {
                          // hasError = false;
                        });
                      },

                      pinBoxWidth: 50,
                      pinBoxHeight: 50,
                      hasUnderline: true,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinTextStyle: const TextStyle(fontSize: 22.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.awesomeTransition,
                      pinTextAnimatedSwitcherDuration:
                          const Duration(milliseconds: 300),
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
