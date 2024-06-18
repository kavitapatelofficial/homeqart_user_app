import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/form_error.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/helper/keyboard.dart';
import 'package:homeqartapp/models/response/login_response.dart';
import 'package:homeqartapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';
import '../../../components/default_button.dart';
import '../../../constant.dart';
import '../../main_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  LoginResponse? loginResponse;
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 15),
          buildPasswordFormField(),
          const SizedBox(height: 15),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: AppColor.primaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const ForgotPasswordScreen();
                })),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          DefaultButton(
              buttonText: "Continue",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  if (phoneNumberController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var data = {
                      "phone": phoneNumberController.text,
                      "password": passwordController.text,
                    };
                    final apiResponse = await showDialog(
                      context: context,
                      builder: (context) => FutureProgressDialog(
                          baseClient.post(false, "https://homeqart.com",
                              "/api/v1/auth/login", data)),
                    );

                    loginResponse = loginResponseFromJson(apiResponse);
                    GetStorageHelper.setdata(loginResponse!);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainScreen();
                    }));
                  }
                }
              },
              buttonColor: AppColor.primaryColor)
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Enter your password",
          fillColor: AppColor.accentWhite,
          filled: true,
          prefixIcon: const Icon(Icons.security),
          border: InputBorder.none),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      maxLength: 10,
      keyboardType: TextInputType.phone,
      controller: phoneNumberController,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError);
        // } else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        // return;
      },
      validator: (value) {
        // if (value!.isEmpty) {
        //   addError(error: kEmailNullError);
        //   return "";
        // } else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        // return null;
      },
      decoration: InputDecoration(
          counterText: "",
          hintText: "Enter your phone number",
          fillColor: AppColor.accentWhite,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const Icon(Icons.person),
          border: InputBorder.none),
    );
  }
}
