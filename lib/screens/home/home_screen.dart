import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/components/product_card.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/helper/shimer_helper.dart';
import 'package:homeqartapp/models/response/get_banners_response.dart';
import 'package:homeqartapp/models/response/product_model.dart';
import 'package:homeqartapp/screens/notification/notification_screen.dart';
import 'package:homeqartapp/screens/search_products/search_products.dart';
import 'package:homeqartapp/screens/shopping_cart/shopping_cart_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentslider = 0;
  BaseClient baseClient = BaseClient();
  ProductModel? productModel;
  List<GetBannersResponse> sliderImages = [];

  Future<ProductModel> getProduct(String path) async {
    var response =
        await baseClient.get(false, "https://homeqart.com", "/api/v1/" + path);
    productModel = productModelFromJson(response);
    return productModel!;
  }

  Future<List<GetBannersResponse>> getbannerImages(String path) async {
    var response =
        await baseClient.get(false, "https://homeqart.com", "/api/v1/" + path);
    sliderImages = getBannersResponseFromJson(response);
    return sliderImages;
  }

  buildTodayDealProducts(context, path) {
    return FutureBuilder<ProductModel>(
      future: getProduct(path),
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

  buildHomeCarouselSlider(context, path) {
    return SizedBox(
      child: FutureBuilder(
          future: getbannerImages(path),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 1,
                ),
                itemCount: (snapshot.data.length / 2).toInt(),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        GestureDetector(
                  onTap: () {},
                  // => Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return SongLyrics(
                  //     musicModel: snapshot.data[itemIndex],
                  //   );
                  // })),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://homeqart.com/storage/app/public/banner/" +
                                      snapshot.data[itemIndex].image,
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
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF343434).withOpacity(0.7),
                                  const Color(0xFF343434).withOpacity(0.15),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 20,
                            ),
                            child: Text(
                              snapshot.data[itemIndex].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ShimmerHelper()
                    .buildBasicShimmer(height: 200, width: double.infinity),
              );
            }
          }),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.accentBgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            iconTheme: IconThemeData(color: AppColor.accentWhite, size: 25),
            expandedHeight: 80,
            backgroundColor: AppColor.primaryColor,
            // leading: const Icon(Icons.menu),
            title: Text(
              "HomeQart Online",
              style: Texttheme.heading.copyWith(color: AppColor.accentWhite),
            ),
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.location_pin,
            //       size: 20,
            //     ),
            //     Text(
            //       "Select location",
            //       style: TextStyle(color: AppColor.accentWhite, fontSize: 14),
            //     ),
            //     const Icon(
            //       Icons.arrow_drop_down,
            //       size: 15,
            //     )
            //   ],
            // ),
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Filter();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Search here',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                preferredSize: const Size.fromHeight(40)),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const NotificationScreen();
                  }));
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ShoppingCartScreen();
                  }));
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi ${box.read('name')}", style: Texttheme.subTitle
                          // .copyWith(color: AppColor.accentWhite),
                          ),
                      Text(greeting(), style: Texttheme.title
                          // .copyWith(color: AppColor.accentWhite),
                          )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: buildHomeCarouselSlider(context, "banners"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latest Products",
                      style: Texttheme.subTitle,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 220,
                  child: buildTodayDealProducts(context, "products/latest"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  8.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Needs",
                      style: Texttheme.subTitle,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  16,
                  8.0,
                  0.0,
                ),
                child: SizedBox(
                  height: 220,
                  child:
                      buildTodayDealProducts(context, "products/daily-needs"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  8.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured Products",
                      style: Texttheme.subTitle,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  16,
                  8.0,
                  0.0,
                ),
                child: SizedBox(
                  height: 220,
                  child: buildTodayDealProducts(context, "products/featured"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  8.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Selling Products",
                      style: Texttheme.subTitle,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  16,
                  8.0,
                  0.0,
                ),
                child: SizedBox(
                  height: 220,
                  child: buildTodayDealProducts(context, "products/up-selling"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  8.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discounted Products",
                      style: Texttheme.subTitle,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  16,
                  8.0,
                  0.0,
                ),
                child: SizedBox(
                  height: 220,
                  child: buildTodayDealProducts(context, "products/discounted"),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    8.0,
                    0.0,
                  ),
                  child: SizedBox(
                    height: 70,
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
