import 'package:flutter/material.dart';
import 'package:homeqartapp/theme.dart';

class TotalBill extends StatelessWidget {
  final String itemCount;
  final String deliveryCharges;
  final String subTotal;
  final String totalAmount;
  const TotalBill(
      {Key? key,
      required this.itemCount,
      required this.deliveryCharges,
      required this.subTotal,
      required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColor.accentWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            getRow('Item', itemCount),
            getRow('Sub Total', '₹$subTotal'),
            getRow('Delivery Charges', '₹$deliveryCharges'),
            const SizedBox(height: 11),
            const Divider(
              endIndent: 15,
              indent: 12,
              color: Colors.black,
              height: 0.5,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    top: 10,
                  ),
                  child: Text('Total',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    top: 10,
                  ),
                  child: Text(
                    '₹$totalAmount',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row getRow(String text1, String text2) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 12),
          child: Text(text1,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 25, top: 12),
          child: Text(
            text2,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        )
      ],
    );
  }
}
