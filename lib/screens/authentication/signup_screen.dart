// import 'package:flutter/material.dart';
// import 'package:homeqartapp/components/appbar_without_actions.dart';
// import '../../../text_theme.dart';
// import '../../../theme.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar("SignUp"),
//       backgroundColor: AppColor.accentBgColor,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formkey,
//           child: ListView(
//             children: [
//               const SizedBox(height: 30.0),
//               Center(
//                 child: Text(
//                   "Signup",
//                   style: Texttheme.mainheading
//                       .copyWith(color: AppColor.accentDarkGrey),
//                 ),
//               ),
//               const SizedBox(
//                 height: 13.0,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   fillColor: AppColor.accentWhite,
//                   filled: true,
//                   border: InputBorder.none,
//                   hintText: "Enter Your Name",
//                   hintStyle: Texttheme.titleRegular
//                       .copyWith(color: AppColor.accentDarkGrey),
//                   contentPadding: const EdgeInsets.only(left: 25.0),
//                 ),
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
//               const SizedBox(height: 15.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   fillColor: AppColor.accentWhite,
//                   filled: true,
//                   border: InputBorder.none,
//                   hintText: "Enter Your Phone Number",
//                   hintStyle: Texttheme.titleRegular
//                       .copyWith(color: AppColor.accentDarkGrey),
//                   contentPadding: const EdgeInsets.only(left: 25.0),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Number can't be empty";
//                   } else if (value.length <= 9 || value.length > 13) {
//                     return "Enter valid number";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(height: 25.0),
//               SizedBox(
//                 height: 50.0,
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: AppColor.primaryColor,
//                   ),
//                   onPressed: () {
//                     if (_formkey.currentState!.validate()) {}
//                   },
//                   child: Text(
//                     "Send OTP",
//                     style:
//                         Texttheme.title.copyWith(color: AppColor.accentWhite),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 1.0,
//                       color: AppColor.accentLightGrey,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     child: Text(
//                       "or",
//                       style: Texttheme.subTitle
//                           .copyWith(color: AppColor.accentDarkGrey),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 1.0,
//                       color: AppColor.accentLightGrey,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20.0),
//               TextFormField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   fillColor: AppColor.accentWhite,
//                   filled: true,
//                   border: InputBorder.none,
//                   hintText: "Enter Password",
//                   hintStyle: Texttheme.titleRegular
//                       .copyWith(color: AppColor.accentDarkGrey),
//                   contentPadding: const EdgeInsets.only(left: 25.0),
//                 ),
//                 // validator: (value) {
//                 //   if (value!.isEmpty) {
//                 //     return "Number can't be empty";
//                 //   } else if (value.length <= 6 || value.length >= 15) {
//                 //     return "Password must be grater than 6 and less than 16";
//                 //   } else {
//                 //     return null;
//                 //   }
//                 // },
//               ),
//               const SizedBox(height: 20.0),
//               TextFormField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   fillColor: AppColor.accentWhite,
//                   filled: true,
//                   border: InputBorder.none,
//                   hintText: "Confirm Password",
//                   hintStyle: Texttheme.titleRegular
//                       .copyWith(color: AppColor.accentDarkGrey),
//                   contentPadding: const EdgeInsets.only(left: 25.0),
//                 ),
//               ),
//               const SizedBox(height: 25.0),
//               SizedBox(
//                 height: 50.0,
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: AppColor.primaryColor,
//                   ),
//                   onPressed: () {
//                     if (_formkey.currentState!.validate()) {}
//                   },
//                   child: Text(
//                     "Submit",
//                     style:
//                         Texttheme.title.copyWith(color: AppColor.accentWhite),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 90.0),
//               Center(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account?",
//                         style: Texttheme.titleRegular
//                             .copyWith(color: AppColor.accentDarkGrey),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           if (_formkey.currentState!.validate()) {}
//                         },
//                         child: Text(
//                           "Sign In",
//                           style: Texttheme.titleRegular
//                               .copyWith(color: AppColor.neturalOrange),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
