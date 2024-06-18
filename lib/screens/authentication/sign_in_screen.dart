// import 'package:flutter/material.dart';
// import 'package:homeqartapp/components/default_button.dart';
// import 'package:homeqartapp/helper/get_storage_helper.dart';
// import 'package:homeqartapp/models/response/login_response.dart';
// import 'package:homeqartapp/screens/authentication/components/decoration.dart';
// import 'package:homeqartapp/screens/main_screen.dart';
// import 'package:homeqartapp/services/base_client.dart';
// import '../../../text_theme.dart';
// import '../../../theme.dart';

// class Signin extends StatefulWidget {
//   const Signin({Key? key}) : super(key: key);

//   @override
//   _SigninState createState() => _SigninState();
// }

// class _SigninState extends State<Signin> {
//   BaseClient baseClient = BaseClient();
//   LoginResponse? loginResponse;
//   final _formKey = GlobalKey<FormState>();
//   final phoneNumberController = TextEditingController();
//   final passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.accentBgColor,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     width: 96,
//                     height: 96,
//                     child: Stack(children: <Widget>[
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Container(
//                           width: 96,
//                           height: 96,
//                           decoration: const BoxDecoration(
//                             color: Color.fromRGBO(49, 204, 68, 1),
//                             borderRadius:
//                                 BorderRadius.all(Radius.elliptical(96, 96)),
//                           ),
//                           child: Center(
//                             child: Stack(
//                               children: const [
//                                 Icon(
//                                   Icons.lock,
//                                   color: Color(0xffffffff),
//                                   size: 48.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ])),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Text(
//                     "Signin to Homeqart",
//                     style: Texttheme.mainheading.copyWith(
//                       color: AppColor.accentDarkGrey,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40.0,
//                 ),
//                 TextFormField(
//                   maxLength: 10,
//                   controller: phoneNumberController,
//                   keyboardType: TextInputType.number,
//                   decoration: DecorationTheme.inputFieldDecoration(
//                     "Enter your phone number",
//                   ).copyWith(counter: const SizedBox.shrink()),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Phone number can't be empty";
//                     } else if (value.length <= 10) {
//                       return "Enter valid phone number";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 const SizedBox(
//                   height: 15.0,
//                 ),
//                 TextFormField(
//                   obscureText: true,
//                   controller: passwordController,
//                   decoration: DecorationTheme.inputFieldDecoration(
//                       "Enter your password"),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Password can't be empty";
//                     } else if (value.length <= 8) {
//                       return "Enter valid password";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 const SizedBox(
//                   height: 30.0,
//                 ),
//                 DefaultButton(
//                   buttonText: "Continue",
//                   press: () async {
//                     if (phoneNumberController.text.isNotEmpty &&
//                         passwordController.text.isNotEmpty) {
//                       var data = {
//                         "phone": phoneNumberController.text,
//                         "password": passwordController.text,
//                       };
//                       final apiResponse = await baseClient.post(false,
//                           "https://homeqart.com", "/api/v1/auth/login", data);
//                       loginResponse = loginResponseFromJson(apiResponse);
//                       GetStorageHelper.setdata(loginResponse!);
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const MainScreen();
//                       }));
//                     }
//                   },
//                   buttonColor: AppColor.primaryColor,
//                 )
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
