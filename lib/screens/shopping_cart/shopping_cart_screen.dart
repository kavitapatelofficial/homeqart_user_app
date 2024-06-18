import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/components/total_bill.dart';
import 'package:homeqartapp/models/response/cart_model.dart';
import 'package:homeqartapp/models/response/cart_summary_model.dart';
import 'package:homeqartapp/screens/address/address_screen.dart';
import 'package:homeqartapp/screens/main_screen.dart';
import 'package:homeqartapp/screens/product_description/product_description_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';
import '../../text_theme.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  ScrollController mainScrollController = ScrollController();
  CartSummaryModel? cartSummaryModel;
  List<int> counter = [];
  bool isLoading = true;
  BaseClient baseClient = BaseClient();
  CartModel? cartModel;

  getCartItems() async {
    var response = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/cart");

    cartModel = cartModelFromJson(response);
    for (var i = 0; i < cartModel!.result!.length; i++) {
      counter.add(cartModel!.result![i].quantity!);
    }

    isLoading = false;
    setState(() {});
  }

  void incrementCounter(index) async {
    setState(() {
      counter[index]++;
    });
    var data = {
      "cart_id": cartModel!.result![index].id!.toString(),
      "value": "1"
    };
    final apiResponse = await baseClient.post(
      true,
      "https://homeqart.com",
      "/api/v1/customer/cart/update",
      data,
    );
    print(apiResponse);
    getCartItems();
    getOrderSummary();
  }

  void decreaseCounter(index) async {
    if (counter[index] != 1) {
      setState(() {
        counter[index]--;
      });
      var data = {
        "cart_id": cartModel!.result![index].id!.toString(),
        "value": "-1"
      };
      final apiResponse = await baseClient.post(
        true,
        "https://homeqart.com",
        "/api/v1/customer/cart/update",
        data,
      );
      print(apiResponse);
      getCartItems();
      getOrderSummary();
    }
  }

  getOrderSummary() async {
    final apiResponse = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/cart/cart_value");
    cartSummaryModel = cartSummaryModelFromJson(apiResponse);
    setState(() {});
  }

  @override
  void initState() {
    getCartItems();
    getOrderSummary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Cart"),
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : cartModel!.result!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2 + 68,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColor.accentWhite,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/sentiment_dissatisfied.svg',
                              height: 150,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Your cart is empty!",
                              style: Texttheme.bodyText1.copyWith(
                                  color: AppColor.accentDarkGrey, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Make your basket happy and add products to purchage.",
                                textAlign: TextAlign.center,
                                style: Texttheme.bodyText1.copyWith(
                                    color: AppColor.accentLightGrey,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: DefaultButton(
                                buttonText: "Start Shopping ",
                                press: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const MainScreen()));
                                },
                                buttonColor: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: CustomScrollView(
                    controller: mainScrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartModel!.result!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ProductDetails(
                                            id: cartModel!
                                                .result![index].productId!);
                                      }));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.accentWhite,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 7, bottom: 9, left: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                "https://homeqart.com/storage/app/public/product/" +
                                                    cartModel!
                                                        .result![index].image!,
                                                height: 70,
                                                width: 70,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 14,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    165,
                                                child: Text(
                                                  cartModel!
                                                      .result![index].name!,
                                                  maxLines: 2,
                                                  style: Texttheme.bodyText1
                                                      .copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    160,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "₹ " +
                                                          cartModel!
                                                              .result![index]
                                                              .sellingPrice!
                                                              .toString(),
                                                      softWrap: true,
                                                      style: Texttheme.title
                                                          .copyWith(
                                                              color: AppColor
                                                                  .primaryColor),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                        ),
                                                        onPressed: () async {
                                                          var data = {
                                                            "cart_id":
                                                                cartModel!
                                                                    .result![
                                                                        index]
                                                                    .id!
                                                                    .toString(),
                                                          };
                                                          final apiResponse =
                                                              await baseClient
                                                                  .post(
                                                            true,
                                                            "https://homeqart.com",
                                                            "/api/v1/customer/cart/remove",
                                                            data,
                                                          );
                                                          print(apiResponse);
                                                          getCartItems();
                                                        },
                                                        child: Text(
                                                          "Remove",
                                                          style: Texttheme
                                                              .bodyText2
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .neturalRed),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 0,
                                                ),
                                                child: Container(
                                                  height: 90,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColor.accentBgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 3),
                                                        child: InkWell(
                                                          onTap: () {
                                                            incrementCounter(
                                                                index);
                                                          },
                                                          child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.black,
                                                              size: 20),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      AnimatedFlipCounter(
                                                        value: counter[index],
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 3),
                                                        child: InkWell(
                                                          onTap: () {
                                                            decreaseCounter(
                                                                index);
                                                          },
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.black,
                                                              size: 20),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // SliverList(
                      //   delegate: SliverChildListDelegate(
                      //     [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 16, horizontal: 16),
                      //         child: Row(
                      //           children: [
                      //             Expanded(
                      //               child: TextField(
                      //                 decoration: InputDecoration(
                      //                   fillColor: AppColor.accentWhite,
                      //                   filled: true,
                      //                   border: InputBorder.none,
                      //                   hintText: 'Enter coupon key',
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 100,
                      //               height: 48,
                      //               child: DefaultButton(
                      //                 buttonColor: AppColor.neturalOrange,
                      //                 buttonText: "Apply",
                      //                 press: () {},
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      cartModel == null
                          ? const SizedBox()
                          : SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  cartModel!.result!.isEmpty
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12, top: 10),
                                          child: TotalBill(
                                            itemCount:
                                                (cartModel!.result!.length)
                                                    .toString(),
                                            subTotal: cartSummaryModel!.subTotal
                                                .toString(),
                                            deliveryCharges: cartSummaryModel!
                                                .shiping
                                                .toString(),
                                            totalAmount: cartSummaryModel!.total
                                                .toString(),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            cartModel!.result!.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                      left: 16,
                                      right: 16,
                                      bottom: 50,
                                    ),
                                    child: DefaultButton(
                                      buttonText: "Checkout",
                                      press: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AddressScreen(
                                            // cartId: cartModel!.,
                                            appBarTitle:
                                                "Select Delivery Address",
                                          );
                                        }));
                                      },
                                      buttonColor: AppColor.primaryColor,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
