import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  final String productTitle;
  final String status;
  final String orderNote;
  final String paymentType;
  final String orderAmount;
  final String paymentStatus;
  final DateTime expectedDeleveryDate;
  const OrderTile(
      {Key? key,
      required this.productTitle,
      required this.status,
      required this.expectedDeleveryDate,
      required this.paymentType,
      required this.paymentStatus,
      required this.orderAmount,
      required this.orderNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: AppColor.accentWhite),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Code",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          productTitle,
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Date",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          DateFormat('d MMM yyyy').format(expectedDeleveryDate),
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          status,
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          paymentType,
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Status",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          paymentStatus,
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cart Value",
                          style: Texttheme.subTitle,
                        ),
                        Text(
                          "₹" + orderAmount,
                          style: Texttheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Order Note",
                      style: Texttheme.subTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderNote,
                      textAlign: TextAlign.justify,
                      style: Texttheme.bodyText2,
                    )
                  ],
                ),
              ),
              // Image.asset(
              //   'assets/images/image 9.png',
              //   height: 100,
              //   width: 100,
              //   fit: BoxFit.fill,
              // ),
            ],
          ),
          // const Divider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: const [
          //         Icon(
          //           Icons.star,
          //           size: 20,
          //           color: Colors.yellow,
          //         ),
          //         Icon(
          //           Icons.star,
          //           size: 20,
          //           color: Colors.yellow,
          //         ),
          //         Icon(
          //           Icons.star,
          //           size: 20,
          //           color: Colors.yellow,
          //         ),
          //         Icon(
          //           Icons.star,
          //           size: 20,
          //           color: Colors.yellow,
          //         ),
          //         Icon(
          //           Icons.star,
          //           size: 20,
          //           color: Colors.yellow,
          //         ),
          //       ],
          //     ),
          //     Text(
          //       "Write a Review",
          //       style:
          //           Texttheme.bodyText1.copyWith(color: AppColor.neturalOrange),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
