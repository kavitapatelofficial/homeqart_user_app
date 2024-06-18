import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/order_placed_model.dart';
import 'package:homeqartapp/models/response/time_slot_model.dart';
import 'package:homeqartapp/screens/order_status/login_success_screen.dart';
import 'package:homeqartapp/screens/status_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';
import 'package:intl/intl.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({Key? key}) : super(key: key);

  @override
  _PaymentOptionScreenState createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  OrderPlacedModel? orderPlacedModel;
  int? selectedValue;
  bool isLoading = true;
  DateTime deliveryDate = DateTime.now();
  BaseClient baseClient = BaseClient();
  final suggetionController = TextEditingController();

  List<TimeSlotModel> slots = [];

  Future<void> _selectCompletionDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != deliveryDate) {
      setState(() {
        deliveryDate = picked;
      });
    }
  }

  getDeliverySlot() async {
    final apiResponse =
        await baseClient.get(true, "https://homeqart.com", "/api/v1/timeSlot");
    slots = timeSlotModelFromJson(apiResponse);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getDeliverySlot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Select Payment Option"),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StatusScreen(
                              title: "Order Status",
                              buttonText: "Trace Order",
                              statusHeading: "Order Placed!",
                              description:
                                  "Customer is first for us Thank You for ordring on Homeqart.",
                              imageUrl: "assets/icons/check_circle.svg",
                              press: () {},
                            );
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.accentWhite,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Container(
                                  height: 60,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: AppColor.neturalOrange,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.delivery_dining_sharp,
                                    size: 45,
                                    color: AppColor.accentWhite,
                                  )),
                              title: Text(
                                "Cash on delivery",
                                style: Texttheme.title
                                    .copyWith(color: AppColor.accentDarkGrey),
                              ),
                              subtitle: Text(
                                'Get your product deliverd to your door steps',
                                style: Texttheme.bodyText1
                                    .copyWith(color: AppColor.accentLightGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.accentWhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prefered Delivery date and time",
                                style: Texttheme.subTitle,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        _selectCompletionDate(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                        backgroundColor: AppColor.accentWhite,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Text(
                                              DateFormat('d MMM yyyy')
                                                  .format(deliveryDate),
                                              style: Texttheme.bodyText2)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: AppColor.accentWhite,
                                        border: Border.all(
                                            color: AppColor.primaryColor,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<int>(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select preferd time slot',
                                            style: Texttheme.bodyText2,
                                          ),
                                          value: selectedValue,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                          ),
                                          iconSize: 20,
                                          onChanged: (newValue) {
                                            selectedValue = newValue!;
                                            setState(() {});
                                          },
                                          items: slots.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                '${item.startTime} - ${item.endTime}',
                                                style: Texttheme.bodyText2,
                                              ),
                                              value: item.id,
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: suggetionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Write your suggetions here........",
                            hintStyle: Texttheme.bodyText2,
                            fillColor: AppColor.accentWhite,
                            filled: true,
                            border: InputBorder.none),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultButton(
                        buttonText: "Place Order",
                        press: () async {
                          var data = {
                            "payment_type": "COD",
                            "delivery_date": deliveryDate.toString(),
                            "order_note": suggetionController.text,
                            "timeSlot": selectedValue.toString()
                          };
                          final apiResponse = await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                              baseClient.post(true, "https://homeqart.com",
                                  "/api/v1/customer/order", data),
                            ),
                          );

                          orderPlacedModel =
                              orderPlacedModelFromJson(apiResponse);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginSuccessScreen(
                                odrId: orderPlacedModel!.orderId!.toString(),
                                message: orderPlacedModel!.message!,
                              );
                            },
                          ));
                        },
                        buttonColor: AppColor.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
