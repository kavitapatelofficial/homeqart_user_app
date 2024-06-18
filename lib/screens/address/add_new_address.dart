import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import '../../../text_theme.dart';
import '../../../theme.dart';

class AddAddress extends StatefulWidget {
  final int? addressId;
  final String appBarTitle;
  final String? address;
  final String? state;
  final String? city;
  final String? pinCode;
  final String? phoneNumber;
  const AddAddress(
      {Key? key,
      required this.appBarTitle,
      this.addressId,
      this.address,
      this.state,
      this.city,
      this.phoneNumber,
      this.pinCode})
      : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool isEdit = false;
  BaseClient baseClient = BaseClient();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setInitData();
    super.initState();
  }

  setInitData() {
    if (widget.address != null) {
      addressController.text = widget.address!;
      stateController.text = widget.state!;
      cityController.text = widget.city!;
      pincodeController.text = widget.pinCode!;
      numberController.text = widget.phoneNumber!;
      isEdit = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.appBarTitle),
      backgroundColor: AppColor.accentBgColor,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          // key: _formkey,
          child: ListView(
            children: [
              const SizedBox(height: 30.0),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  fillColor: AppColor.accentWhite,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "H.No 10 Example Colony",
                  hintStyle: Texttheme.bodyText2
                      .copyWith(color: AppColor.accentLightGrey),
                  contentPadding: const EdgeInsets.only(left: 15.0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name can't be empty";
                  } else if (value.length <= 2) {
                    return "Name sould be greater than 2";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(
                  fillColor: AppColor.accentWhite,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "State Name",
                  hintStyle: Texttheme.bodyText2
                      .copyWith(color: AppColor.accentLightGrey),
                  contentPadding: const EdgeInsets.only(left: 15.0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Number can't be empty";
                  } else if (value.length <= 9 || value.length > 13) {
                    return "Enter valid number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  fillColor: AppColor.accentWhite,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "City Name",
                  hintStyle: Texttheme.bodyText2
                      .copyWith(color: AppColor.accentLightGrey),
                  contentPadding: const EdgeInsets.only(left: 15.0),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                maxLength: 6,
                controller: pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: AppColor.accentWhite,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Enter Pincode",
                  hintStyle: Texttheme.bodyText2
                      .copyWith(color: AppColor.accentLightGrey),
                  contentPadding: const EdgeInsets.only(left: 15.0),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                maxLength: 10,
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: AppColor.accentWhite,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Reciver Contact Number",
                  hintStyle: Texttheme.bodyText2
                      .copyWith(color: AppColor.accentLightGrey),
                  contentPadding: const EdgeInsets.only(left: 15.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultButton(
                buttonText: "Continue",
                press: () async {
                  if (addressController.text.isNotEmpty &&
                      stateController.text.isNotEmpty &&
                      cityController.text.isNotEmpty &&
                      pincodeController.text.isNotEmpty &&
                      numberController.text.isNotEmpty) {
                    var data = {
                      "address": addressController.text,
                      "state": stateController.text,
                      "city": cityController.text,
                      "pincode": pincodeController.text,
                      "phone": numberController.text
                    };
                    isEdit
                        ? await showDialog(
                            context: context,
                            builder: (context) =>
                                FutureProgressDialog(baseClient.post(
                              true,
                              "https://homeqart.com",
                              "/api/v1/customer/address/update/${widget.addressId}",
                              data,
                            )),
                          )
                        : await showDialog(
                            context: context,
                            builder: (context) =>
                                FutureProgressDialog(baseClient.post(
                              true,
                              "https://homeqart.com",
                              "/api/v1/customer/address/add",
                              data,
                            )),
                          );

                    Navigator.pop(context, true);
                  }
                },
                buttonColor: AppColor.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
