import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';
import 'otp_form.dart';

class Body extends StatefulWidget {
  final String mobileNUmber;
  final String userId;

  const Body({Key? key, required this.mobileNUmber, required this.userId})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  BaseClient baseClient = BaseClient();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            Text(
              "OTP Verification",
              style: Texttheme.heading,
            ),
            Text(
              "We sent your code to ${widget.mobileNUmber}",
              style: Texttheme.subTitle,
            ),
            buildTimer(),
            OtpForm(
              userId: widget.userId,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                var data = {"user_id": widget.userId};
                final apiResponse = FutureProgressDialog(
                  baseClient.post(
                    false,
                    "https://homeqart.com",
                    "/api/v1/auth/resend_code",
                    data,
                  ),
                );
                // Fluttertoast.showToast(
                //   msg: ,
                //   toastLength: Toast.LENGTH_SHORT,
                //   gravity: ToastGravity.SNACKBAR,
                //   timeInSecForIosWeb: 2,
                //   backgroundColor: AppColor.neturalRed,
                //   textColor: Colors.white,
                // );
              },
              child: const Text(
                "Resend OTP Code",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: Texttheme.subTitle,
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text("00:${value.toInt()}",
              style: Texttheme.subTitle.copyWith(color: AppColor.primaryColor)),
        ),
      ],
    );
  }
}
