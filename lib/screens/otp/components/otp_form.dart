import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/verify_otp_model.dart';
import 'package:homeqartapp/screens/sign_in/sign_in_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';
import '../../../constant.dart';

class OtpForm extends StatefulWidget {
  final String userId;
  const OtpForm({Key? key, required this.userId}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  BaseClient baseClient = BaseClient();
  VerifyOtpResponse? verifyOtpResponse;
  String otp = "";
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    var temp = otp + value;
                    otp = temp;
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    var temp = otp + value;
                    otp = temp;
                    nextField(value, pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    var temp = otp + value;
                    otp = temp;
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    var temp = otp + value;
                    otp = temp;
                    nextField(value, pin5FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    var temp = otp + value;
                    otp = temp;
                    nextField(value, pin6FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                      var temp = otp + value;
                      otp = temp;
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          DefaultButton(
            buttonText: "Continue",
            press: () async {
              var data = {"user_id": widget.userId, "otp_code": otp};
              final apiResponse = await showDialog(
                context: context,
                builder: (context) => FutureProgressDialog(baseClient.post(
                  false,
                  "https://homeqart.com",
                  "/api/v1/auth/confirm_code",
                  data,
                )),
              );
              verifyOtpResponse = verifyOtpResponseFromJson(apiResponse);
              if (verifyOtpResponse!.result!) {
                Fluttertoast.showToast(
                  msg: verifyOtpResponse!.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 2,
                  backgroundColor: AppColor.primaryColor,
                  textColor: Colors.white,
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const SignInScreen();
                }));
              } else {
                Fluttertoast.showToast(
                  msg: verifyOtpResponse!.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 2,
                  backgroundColor: AppColor.neturalRed,
                  textColor: Colors.white,
                );
              }
            },
            buttonColor: AppColor.primaryColor,
          )
        ],
      ),
    );
  }
}
