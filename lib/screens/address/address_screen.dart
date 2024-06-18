import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/address_response.dart';
import 'package:homeqartapp/screens/address/add_new_address.dart';
import 'package:homeqartapp/screens/payment_option/payment_option_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';

import '../../text_theme.dart';

class AddressScreen extends StatefulWidget {
  final String? cartId;
  final String appBarTitle;
  const AddressScreen({Key? key, required this.appBarTitle, this.cartId})
      : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<AddressModel> addressList = [];
  int? selectedIndex;
  List<bool> counter = [];
  BaseClient baseClient = BaseClient();

  getAddressList() async {
    var response = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/address/list");
    addressList = addressModelFromJson(response);
    for (var i = 0; i < addressList.length; i++) {
      counter.add(false);
    }
    setState(() {});
  }

  @override
  void initState() {
    // implement initState
    getAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.appBarTitle),
      backgroundColor: AppColor.accentBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: addressList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.accentWhite,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Checkbox(
                                value: counter[index],
                                activeColor: AppColor.primaryColor,
                                onChanged: (value) {
                                  if (selectedIndex != null) {
                                    counter[selectedIndex!] = false;
                                    setState(() {});
                                  }
                                  counter[index] = value!;
                                  selectedIndex = index;
                                  setState(() {});
                                }),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 105,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final bool isadded =
                                              await Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                            return AddAddress(
                                              addressId: addressList[index].id,
                                              appBarTitle: "Edit Address",
                                              address:
                                                  addressList[index].address,
                                              city: addressList[index].city,
                                              state: addressList[index].country,
                                              pinCode: addressList[index]
                                                  .pinCode
                                                  .toString(),
                                              phoneNumber:
                                                  addressList[index].phone,
                                            );
                                          }));
                                          print(isadded);
                                          if (isadded) {
                                            getAddressList();
                                          }
                                        },
                                        child: Text(
                                          "Edit",
                                          style: Texttheme.bodyText1.copyWith(
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var response = await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                FutureProgressDialog(
                                                    baseClient.get(
                                              true,
                                              "https://homeqart.com",
                                              "/api/v1/customer/address/delete/${addressList[index].id}",
                                            )),
                                          );
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                FutureProgressDialog(
                                                    getAddressList()),
                                          );
                                        },
                                        child: Text(
                                          "Remove",
                                          style: Texttheme.bodyText1.copyWith(
                                              color: AppColor.neturalRed),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Mobile: ${addressList[index].phone}',
                                  style: Texttheme.bodyText1.copyWith(
                                      color: AppColor.accentLightGrey),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 105,
                                  child: Text(
                                    addressList[index].address!,
                                    style: Texttheme.bodyText1.copyWith(
                                        color: AppColor.accentLightGrey),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 105,
                                  child: Text(
                                    addressList[index].city! +
                                        ", " +
                                        addressList[index].country! +
                                        ", " +
                                        addressList[index].pinCode!.toString(),
                                    style: Texttheme.bodyText1.copyWith(
                                        color: AppColor.accentLightGrey),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultButton(
                  buttonText: "Add New Address",
                  press: () async {
                    final isadded = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AddAddress(
                        appBarTitle: "Add New Address",
                      );
                    }));
                    print(isadded);
                    if (isadded != null) {
                      if (isadded) {
                        getAddressList();
                      }
                    }
                  },
                  buttonColor: AppColor.neturalOrange,
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: selectedIndex == null
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: DefaultButton(
                buttonText: "Continue",
                press: () async {
                  var data = {
                    "address_id": addressList[selectedIndex!].id,
                  };
                  final apiResponse = await showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(baseClient.post(
                        true,
                        "https://homeqart.com",
                        "/api/v1/customer/order/save_address",
                        data)),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const PaymentOptionScreen();
                  }));
                },
                buttonColor: AppColor.primaryColor,
              ),
            ),
    );
  }
}
