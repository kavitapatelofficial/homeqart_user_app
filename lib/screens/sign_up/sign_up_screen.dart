import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/register_user_response.dart';
import 'package:homeqartapp/screens/otp/otp_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RegisterUser? registerUser;
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();
  String? userName;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Sign Up"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .08),
                Text(
                  "Register Account",
                  style: Texttheme.title,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Complete your details or continue",
                  style: Texttheme.bodyText2,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => userName = newValue,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppColor.accentWhite,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Name is Required*';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => phoneNumber = newValue,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppColor.accentWhite,
                    prefixIcon: const Icon(Icons.phone_android_rounded),
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Name is Required*';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColor.accentWhite,
                      prefixIcon: const Icon(Icons.email)),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Email is Required*';
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
                        "name": userName,
                        "email": email,
                        "phone": phoneNumber,
                        "password": confirmPassword
                      };
                      final apiResponse = await showDialog(
                        context: context,
                        builder: (context) => FutureProgressDialog(
                            baseClient.post(false, "https://homeqart.com",
                                "/api/v1/auth/register", data)),
                      );
                      registerUser = registerUserFromJson(apiResponse);
                      if (registerUser!.result!) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return OtpScreen(
                            mobileNUmber: phoneNumber.toString(),
                            userId: registerUser!.userId!.toString(),
                          );
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "By continuing you confirm that you agree with our term and condition",
                  style: Texttheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
