// import 'package:flutter/material.dart';
// import 'package:homeqartapp/components/default_button.dart';
// import 'package:homeqartapp/components/appbar_without_actions.dart';
// import 'package:homeqartapp/screens/authentication/components/decoration.dart';
// import '../../../theme.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({Key? key}) : super(key: key);

//   @override
//   _ForgotPasswordState createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar("Forgot Password"),
//       backgroundColor: AppColor.accentBgColor,
//       body: SafeArea(
//           child: Form(
//         // key: _formkey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),
//               Center(
//                 child: Stack(
//                   children: const [
//                     Icon(
//                       Icons.lock,
//                       color: Color(0xff31CC44),
//                       size: 180.0,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextFormField(
//                 // controller: _phoneController,
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
//                 height: 20.0,
//               ),
//               DefaultButton(
//                 buttonText: "Get OTP",
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
