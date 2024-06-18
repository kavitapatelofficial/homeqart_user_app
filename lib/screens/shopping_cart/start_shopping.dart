import 'package:flutter/material.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/text_theme.dart';
import '../../theme.dart';

class StartShopping extends StatefulWidget {
  const StartShopping({Key? key}) : super(key: key);

  @override
  _StartShoppingState createState() => _StartShoppingState();
}

class _StartShoppingState extends State<StartShopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Start Shopping",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2 + 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xffeceff1),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/happy_icon.jpg',
                      height: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your cart is empty!",
                      style: Texttheme.bodyText1.copyWith(
                          color: AppColor.accentDarkGrey, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Make your basket happy and add products to purchage theme",
                        textAlign: TextAlign.center,
                        style: Texttheme.bodyText1.copyWith(
                            color: AppColor.accentLightGrey, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    DefaultButton(
                        buttonText: "Start Shopping ",
                        press: () {},
                        buttonColor: AppColor.primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
