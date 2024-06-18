import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/default_button.dart';
import 'package:homeqartapp/models/response/wish_list_model.dart';
import 'package:homeqartapp/screens/product_description/product_description_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

import '../main_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isLoading = true;
  BaseClient baseClient = BaseClient();
  WishListModel? wishListModel;

  getWishlist() async {
    var response = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/wishlist");

    wishListModel = wishListModelFromJson(response);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Wishlist"),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : wishListModel!.result!.isEmpty
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
                              "Your wishlist is empty!",
                              style: Texttheme.bodyText1.copyWith(
                                  color: AppColor.accentDarkGrey, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Make your wishlist happy and add your favourite products.",
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
                                buttonText: "Add products",
                                press: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MainScreen(),
                                    ),
                                  );
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
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: wishListModel!.result!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return ProductDetails(
                                      id: wishListModel!
                                          .result![index].productId!);
                                }));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
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
                                                wishListModel!
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
                                                160,
                                            child: Text(
                                              wishListModel!
                                                  .result![index].name!,
                                              maxLines: 2,
                                              style: Texttheme.bodyText1
                                                  .copyWith(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "₹ " +
                                                      wishListModel!
                                                          .result![index].price!
                                                          .toString(),
                                                  softWrap: true,
                                                  style:
                                                      Texttheme.title.copyWith(
                                                    color: AppColor
                                                        .accentLightGrey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "₹ " +
                                                      wishListModel!
                                                          .result![index]
                                                          .sellingPrice!
                                                          .toString(),
                                                  softWrap: true,
                                                  style: Texttheme.title
                                                      .copyWith(
                                                          color: AppColor
                                                              .neturalOrange),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () async {
                                              var data = {
                                                "product_id": wishListModel!
                                                    .result![index].productId!
                                                    .toString(),
                                              };
                                              final apiResponse =
                                                  await baseClient.post(
                                                true,
                                                "https://homeqart.com",
                                                "/api/v1/customer/wishlist/add",
                                                data,
                                              );
                                              print(apiResponse);
                                              getWishlist();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppColor.neturalRed,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
