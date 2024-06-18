import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/screens/product_description/product_description_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final int offAmount;
  final int mrp;
  final int sellingPrice;
  final int wishlistCount;
  const ProductCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.mrp,
    required this.offAmount,
    required this.sellingPrice,
    required this.wishlistCount,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  BaseClient baseClient = BaseClient();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(id: widget.id);
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.image.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Icon(
                        Icons.photo,
                        size: 50,
                        color: AppColor.accentLightGrey,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.info,
                        size: 50,
                        color: AppColor.accentLightGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(widget.name,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: Texttheme.bodyText1),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₹" + widget.sellingPrice.toString(),
                              textAlign: TextAlign.start,
                              style: Texttheme.subTitle
                                  .copyWith(color: AppColor.neturalOrange),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "₹" + widget.mrp.toString(),
                              textAlign: TextAlign.start,
                              style: Texttheme.subTitle.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1.5),
                          child: Text(
                            "Save ₹ ${widget.offAmount}",
                            style: Texttheme.bodyText1
                                .copyWith(color: AppColor.accentWhite),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
