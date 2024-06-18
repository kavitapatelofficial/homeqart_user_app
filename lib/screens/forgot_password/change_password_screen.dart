import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/register_user_response.dart';
import 'package:homeqartapp/screens/sign_in/sign_in_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import '../../theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userId;
  const ChangePasswordScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  RegisterUser? registerUser;
  String? password;
  String? otp;
  String? confirmPassword;
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Change password"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .07),
                Icon(
                  Icons.lock,
                  color: AppColor.accentLightGrey,
                  size: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => otp = newValue,
                  maxLength: 6,
                  decoration: InputDecoration(
                      hintText: '6 Digit OTP',
                      border: InputBorder.none,
                      counterText: "",
                      filled: true,
                      fillColor: AppColor.accentWhite,
                      prefixIcon: const Icon(Icons.security)),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'OTP is required*';
                    } else if (text.length < 6) {
                      return "Please enter valid 6 Digit otp";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => password = newValue,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColor.accentWhite,
                      prefixIcon: const Icon(Icons.lock)),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Password is required*';
                    } else if (text.length < 8) {
                      return "Password must contain atleast 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSaved: (newValue) => confirmPassword = newValue,
                  decoration: InputDecoration(
                      hintText: 'Confirm password',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColor.accentWhite,
                      prefixIcon: const Icon(Icons.lock)),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Confirm password is Required*';
                    }
                    if (password != confirmPassword) {
                      return "Password and confirm password doesn't match";
                    }
                    if (text.length < 8) {
                      return "Password must contain atleast 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultButton(
                  buttonText: "Continue",
                  press: () async {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      var data = {
                        "user_id": widget.userId,
                        "otp_code": otp,
                        "password": password,
                      };
                      final apiResponse = await showDialog(
                        context: context,
                        builder: (context) => FutureProgressDialog(
                          baseClient.post(false, "https://homeqart.com",
                              "/api/v1/auth/password/confirm_reset", data),
                        ),
                      );
                      registerUser = registerUserFromJson(apiResponse);
                      if (registerUser!.result!) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return const SignInScreen();
                        }));
                      } else {
                        Fluttertoast.showToast(
                          msg: registerUser!.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColor.neturalRed,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  buttonColor: AppColor.primaryColor,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
