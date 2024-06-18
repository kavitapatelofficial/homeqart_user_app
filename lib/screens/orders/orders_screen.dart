import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/order_model.dart';
import 'package:homeqartapp/screens/orders/components/order_tile.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;
  List<OrderModel> orderModel = [];
  BaseClient baseClient = BaseClient();

  getOrderList() async {
    final apiResponse = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/order/list");
    orderModel = orderModelFromJson(apiResponse);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("My Orders"),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orderModel.isEmpty
              ? const Center(
                  child: Text(
                      "You have not ordered anything yet please order someting"),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderModel.length,
                          itemBuilder: (_, i) {
                            return OrderTile(
                              productTitle: orderModel[i].code.toString(),
                              expectedDeleveryDate: orderModel[i].deliveryDate!,
                              status: orderModel[i].orderStatus.toString(),
                              orderAmount: orderModel[i].orderAmount.toString(),
                              orderNote: orderModel[i].orderNote.toString(),
                              paymentStatus:
                                  orderModel[i].paymentStatus.toString(),
                              paymentType:
                                  orderModel[i].paymentMethod.toString(),
                            );
                          })),
                )),
    );
  }
}
