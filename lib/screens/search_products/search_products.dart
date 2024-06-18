import 'package:flutter/material.dart';
import 'package:homeqartapp/components/product_card.dart';
import 'package:homeqartapp/models/response/product_model.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class Filter extends StatefulWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  BaseClient baseClient = BaseClient();
  ProductModel? productModel;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  onTextFieldChange() async {
    final apiResponse = await baseClient.get(false, "https://homeqart.com",
        "/api/v1/products/search?name=${_searchController.text}");
    print(apiResponse);
    productModel = productModelFromJson(apiResponse);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.accentWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "What are you looking for",
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {
                    onTextFieldChange();
                  },
                  icon: const Icon(Icons.search)),
              hintStyle:
                  Texttheme.subTitle.copyWith(color: AppColor.accentLightGrey),
              contentPadding: const EdgeInsets.only(left: 10, top: 5),
            ),
          ),
        ),
      ),
      body: productModel == null
          ? const SizedBox()
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 220,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: productModel!.products!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ProductCard(
                          id: productModel!.products![index].id!,
                          image:
                              "https://homeqart.com/storage/app/public/product/" +
                                  productModel!.products![index].image![0],
                          name: productModel!.products![index].name!,
                          mrp: productModel!.products![index].mrp!,
                          offAmount: productModel!.products![index].offAmount!,
                          sellingPrice:
                              productModel!.products![index].sellingPrice!,
                          wishlistCount:
                              productModel!.products![index].wishlistCount!);
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
