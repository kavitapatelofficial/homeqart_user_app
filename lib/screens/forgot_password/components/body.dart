import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/components/form_error.dart';
import 'package:homeqartapp/components/no_account_text.dart';
import 'package:homeqartapp/models/response/register_user_response.dart';
import 'package:homeqartapp/screens/forgot_password/change_password_screen.dart';
// import 'package:homeqartapp/screens/otp/otp_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .15),
              Text("Forgot Password", style: Texttheme.heading),
              const SizedBox(height: 10),
              Text(
                "Please enter your phone number and we will send \nyou a link to return to your account",
                style: Texttheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  BaseClient baseClient = BaseClient();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  final phoneNUmberController = TextEditingController();
  RegisterUser? registerUser;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            maxLength: 10,
            controller: phoneNUmberController,
            onChanged: (value) {},
            validator: (value) {},
            decoration: InputDecoration(
                hintText: "Enter your phone number",
                fillColor: AppColor.accentWhite,
                filled: true,
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: const Icon(Icons.phone_android_rounded),
                border: InputBorder.none),
          ),
          const SizedBox(height: 30),
          FormError(errors: errors),
          const SizedBox(height: 10),
          DefaultButton(
              buttonText: "Continue",
              press: () async {
                var data = {"phone": phoneNUmberController.text};
                final apiResponse = await showDialog(
                  context: context,
                  builder: (context) => FutureProgressDialog(baseClient.post(
                      false,
                      "https://homeqart.com",
                      "/api/v1/auth/password/forget_request",
                      data)),
                );

                registerUser = registerUserFromJson(apiResponse);

                if (registerUser!.result!) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangePasswordScreen(
                        userId: registerUser!.userId!.toString());
                  }));
                }
              },
              buttonColor: AppColor.primaryColor),
          const SizedBox(height: 10),
          const NoAccountText(),
        ],
      ),
    );
  }
}
