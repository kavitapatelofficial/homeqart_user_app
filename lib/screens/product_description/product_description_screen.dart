import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/components/product_card.dart';
import 'package:homeqartapp/helper/shimer_helper.dart';
import 'package:homeqartapp/models/response/product_detail_model.dart';
import 'package:homeqartapp/models/response/product_model.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';
import 'package:universal_html/html.dart' as html;

class ProductDetails extends StatefulWidget {
  final int id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  BaseClient baseClient = BaseClient();
  ProductModel? productModel;
  bool isLoading = true;
  int _currentImage = 0;
  CarouselController imageCarouselController = CarouselController();
  ScrollController mainScrollController = ScrollController();
  ProductDetailModel? productDetailModel;
  int quantity = 1;
  bool isShowVideo = false;
  bool isShowPdf = false;
  bool showTitle = true;
  var tops = 0.0;

  @override
  void dispose() {
    mainScrollController.dispose();
    super.dispose();
  }

  fetchProductDetails() async {
    var response = await baseClient.get(false, "https://homeqart.com",
        "/api/v1/products/details/${widget.id.toString()}");
    productDetailModel = productDetailModelFromJson(response);
    isLoading = false;
    setState(() {});
  }

  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  Future<ProductModel> getProduct() async {
    var response = await baseClient.get(false, "https://homeqart.com",
        "/api/v1/products/related-products/${widget.id}");
    productModel = productModelFromJson(response);
    return productModel!;
  }

  Future<void> _onPageRefresh() async {
    // reset();
    // fetchAll();
  }

  @override
  void initState() {
    fetchProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SnackBar _addedToCartSnackbar = SnackBar(
      content: Text(
        'Added to cart',
        style: TextStyle(color: AppColor.accentLightGrey),
      ),
      backgroundColor: AppColor.accentBgColor,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'SHOW CART',
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Cart(has_bottomnav: false);
          // })).then((value) {
          //   onPopped(value);
          // });
        },
        textColor: AppColor.primaryColor,
        disabledTextColor: Colors.grey,
      ),
    );

    return SafeArea(
      top: true,
      child: Scaffold(
          bottomNavigationBar: buildBottomAppBar(context, _addedToCartSnackbar),
          backgroundColor: AppColor.accentWhite,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: _onPageRefresh,
                  child: CustomScrollView(
                    controller: mainScrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverAppBar(
                        leadingWidth: 50,
                        leading: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColor.accentWhite,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        backgroundColor: AppColor.accentWhite,
                        expandedHeight: 350,
                        pinned: true,
                        flexibleSpace: LayoutBuilder(builder: (context, cons) {
                          tops = cons.biggest.height;
                          return FlexibleSpaceBar(
                            centerTitle: false,
                            collapseMode: CollapseMode.parallax,
                            stretchModes: const [
                              StretchMode.zoomBackground,
                            ],
                            background: buildProductImageCarouselSlider(),
                          );
                        }),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: AppColor.primaryColor,
                              child: IconButton(
                                onPressed: () async {
                                  Share.share(
                                      'https://homeqart.com/product_detail/${productDetailModel!.products!.id}');
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: AppColor.accentWhite,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16.0,
                                8.0,
                                16.0,
                                0.0,
                              ),
                              child: productDetailModel != null
                                  ? buildRatingAndWishButtonRow()
                                  : ShimmerHelper().buildBasicShimmer(
                                      height: 30.0,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16.0,
                                8.0,
                                16.0,
                                0.0,
                              ),
                              child: productDetailModel != null
                                  ? Text(
                                      productDetailModel!.products!.name!,
                                      style: Texttheme.title.copyWith(
                                        color: AppColor.accentDarkGrey,
                                      ),
                                      maxLines: 2,
                                    )
                                  : ShimmerHelper().buildBasicShimmer(
                                      height: 30.0,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            0.0,
                          ),
                          child: productDetailModel != null
                              ? buildMainPriceRow()
                              : ShimmerHelper().buildBasicShimmer(
                                  height: 30.0,
                                ),
                        ),
                      ])),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            0.0,
                          ),
                          child: productDetailModel != null
                              ? Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: AppColor.neturalOrange,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      "You Save ₹" +
                                          productDetailModel!
                                              .products!.offAmount
                                              .toString() +
                                          " in this product",
                                      style: Texttheme.subTitle.copyWith(
                                        color: AppColor.accentWhite,
                                      ),
                                    ),
                                  ),
                                )
                              : ShimmerHelper().buildBasicShimmer(
                                  height: 30.0,
                                ),
                        ),
                      ])),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _parseHtmlString(
                                productDetailModel!.products!.description!),
                            textAlign: TextAlign.justify,
                            style: Texttheme.bodyText2
                                .copyWith(color: AppColor.accentLightGrey),
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            "Products you may also like",
                            style: Texttheme.title
                                .copyWith(color: AppColor.accentDarkGrey),
                          ),
                        ),
                      ])),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 220,
                              child: buildTodayDealProducts(context),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )),
    );
  }

  Row buildMainPriceRow() {
    return Row(
      children: [
        Text(
          "₹" + productDetailModel!.products!.price!.toString(),
          style: Texttheme.subTitle.copyWith(
            color: AppColor.accentLightGrey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
            "₹" +
                productDetailModel!.products!.sellingPrice!.toString() +
                "/" +
                productDetailModel!.products!.unit.toString(),
            style: Texttheme.subTitle.copyWith(color: AppColor.neturalOrange)),
        const Spacer(),
        productDetailModel!.products!.totalStock == 0
            ? Text(
                "Out of stock",
                style:
                    Texttheme.subTitle.copyWith(color: AppColor.neturalOrange),
              )
            : Text(
                "Available",
                style:
                    Texttheme.subTitle.copyWith(color: AppColor.primaryColor),
              )
      ],
    );
  }

  buildBottomAppBar(BuildContext context, _addedToCartSnackbar) {
    return Builder(builder: (BuildContext context) {
      return BottomAppBar(
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: AppColor.accentWhite),
                    child: Text(
                      "Add to wishlist",
                      style: Texttheme.title
                          .copyWith(color: AppColor.accentLightGrey),
                    ),
                    onPressed: () async {
                      var data = {
                        "product_id": widget.id.toString(),
                      };
                      final apiResponse = await showDialog(
                        context: context,
                        builder: (context) =>
                            FutureProgressDialog(baseClient.post(
                          true,
                          "https://homeqart.com",
                          "/api/v1/customer/wishlist/add",
                          data,
                        )),
                      );
                      Fluttertoast.showToast(
                        msg: "Item added to your wishlist",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 2,
                        backgroundColor: AppColor.primaryColor,
                        textColor: Colors.white,
                      );
                      fetchProductDetails();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryColor,
                    ),
                    child: Text(
                      "Add to cart",
                      style:
                          Texttheme.title.copyWith(color: AppColor.accentWhite),
                    ),
                    onPressed: () async {
                      var data = {
                        "product_id":
                            productDetailModel!.products!.id.toString(),
                      };
                      final apiResponse = await await showDialog(
                        context: context,
                        builder: (context) =>
                            FutureProgressDialog(baseClient.post(
                          true,
                          "https://homeqart.com",
                          "/api/v1/customer/cart/add",
                          data,
                        )),
                      );
                      Fluttertoast.showToast(
                        msg: "Item added to your cart",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 2,
                        backgroundColor: AppColor.primaryColor,
                        textColor: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  buildRatingAndWishButtonRow() {
    return Row(
      children: [
        productDetailModel!.products!.rating!.isEmpty
            ? const SizedBox()
            : RatingBar(
                itemSize: 18.0,
                ignoreGestures: true,
                initialRating: double.parse(
                    productDetailModel!.products!.rating![0].average!),
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.amber),
                  empty: const Icon(Icons.star_outline,
                      color: Color.fromRGBO(224, 224, 225, 1)),
                  half: const Icon(Icons.star_half, color: Colors.amber),
                ),
                itemPadding: const EdgeInsets.only(right: 1.0),
                onRatingUpdate: (rating) {
                  //print(rating);
                },
              ),
        productDetailModel!.products!.rating!.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "(" +
                      productDetailModel!.products!.rating![0].average!
                          .substring(0, 3) +
                      ")",
                  style: const TextStyle(
                      color: Color.fromRGBO(152, 152, 153, 1), fontSize: 14),
                ),
              ),
        const Spacer(),
        InkWell(
          onTap: () async {
            var data = {
              "product_id": widget.id.toString(),
            };
            final apiResponse = await baseClient.post(
              true,
              "https://homeqart.com",
              "/api/v1/customer/wishlist/add",
              data,
            );
            fetchProductDetails();
          },
          child: Icon(
            productDetailModel!.products!.wishlistCount == 0
                ? Icons.favorite_outline_rounded
                : Icons.favorite,
            color: AppColor.neturalRed,
            size: 25,
          ),
        ),
      ],
    );
  }

  buildProductImageCarouselSlider() {
    if (productDetailModel!.products!.image!.isEmpty) {
      return Row(
        children: [
          Expanded(
            child: ShimmerHelper().buildBasicShimmer(),
          ),
        ],
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        width: double.infinity,
        child: CarouselSlider(
          carouselController: imageCarouselController,
          options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                // setState(() {
                _currentImage = index;
                // });
              }),
          items: productDetailModel!.products!.image!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: <Widget>[
                    InkWell(
                      child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://homeqart.com/storage/app/public/product/" +
                                  i,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            productDetailModel!.products!.image!.map((url) {
                          int index =
                              productDetailModel!.products!.image!.indexOf(url);
                          return Container(
                            width: 7.0,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImage == index
                                  ? AppColor.primaryColor
                                  : AppColor.neturalOrange,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      );
    }
  }

  buildTodayDealProducts(context) {
    return FutureBuilder<ProductModel>(
      future: getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        } else if (snapshot.hasData) {
          productModel = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productModel!.products!.length,
            itemExtent: 170,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductCard(
                id: productModel!.products![index].id!,
                name: productModel!.products![index].name!,
                image: "https://homeqart.com/storage/app/public/product/" +
                    productModel!.products![index].image![0],
                mrp: productModel!.products![index].mrp!,
                sellingPrice: productModel!.products![index].sellingPrice!,
                offAmount: productModel!.products![index].offAmount!,
                wishlistCount: productModel!.products![index].wishlistCount!,
              );
            },
          );
        } else {
          return ListView.builder(
            itemExtent: 170,
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child:
                    ShimmerHelper().buildBasicShimmer(height: 220, width: 170),
              );
            },
          );
        }
      },
    );
  }
}
