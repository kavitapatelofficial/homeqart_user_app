// import 'package:flutter/material.dart';
// import 'package:homeqartapp/components/default_button.dart';
// import 'package:homeqartapp/screens/authentication/components/decoration.dart';
// import '../../../text_theme.dart';
// import '../../../theme.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.accentBgColor,
//       body: SafeArea(
//           child: Form(
//         key: _formkey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   "Signup",
//                   style: Texttheme.mainheading.copyWith(
//                     color: AppColor.accentDarkGrey,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 13.0,
//               ),
//               TextFormField(
//                 controller: _nameController,
//                 decoration:
//                     DecorationTheme.inputFieldDecoration("Enter your name"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Name can't be empty";
//                   } else if (value.length <= 2) {
//                     return "Name sould be greater than 2";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration:
//                     DecorationTheme.inputFieldDecoration("Enter your email"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Email can't be empty";
//                   } else if (value.length <= 2) {
//                     return "Enter valid email address";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 maxLength: 10,
//                 keyboardType: TextInputType.number,
//                 decoration: DecorationTheme.inputFieldDecoration(
//                   "Enter your phone number",
//                 ).copyWith(counter: const SizedBox.shrink()),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Phone number can't be empty";
//                   } else if (value.length <= 10) {
//                     return "Enter valid phone number";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration:
//                     DecorationTheme.inputFieldDecoration("Enter your password"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Password can't be empty";
//                   } else if (value.length <= 8) {
//                     return "Enter valid password";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: true,
//                 decoration:
//                     DecorationTheme.inputFieldDecoration("Enter your password"),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Confirm password can't be empty";
//                   } else if (value.length <= 8) {
//                     return "Enter valid confirm password";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ),
//               DefaultButton(
//                 buttonText: "Continue",
//                 press: () {},
//                 buttonColor: AppColor.primaryColor,
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
