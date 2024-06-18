import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/components/product_card.dart';
import 'package:homeqartapp/models/response/product_model.dart';
import 'package:homeqartapp/services/base_client.dart';

class ShowAllProductsScreen extends StatefulWidget {
  final String subCategoryId;
  final String subCategoryName;
  const ShowAllProductsScreen(
      {Key? key, required this.subCategoryId, required this.subCategoryName})
      : super(key: key);

  @override
  _ShowAllProductsScreenState createState() => _ShowAllProductsScreenState();
}

class _ShowAllProductsScreenState extends State<ShowAllProductsScreen> {
  bool isLoading = true;
  BaseClient baseClient = BaseClient();
  ProductModel? productModel;

  getData() async {
    final apiResponse = await baseClient.get(false, "https://homeqart.com",
        "/api/v1/categories/products/${widget.subCategoryId}/all");
    productModel = productModelFromJson(apiResponse);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.subCategoryName),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productModel!.products!.isEmpty
              ? const Center(
                  child: Text('Nothing to Show'),
                )
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              offAmount:
                                  productModel!.products![index].offAmount!,
                              sellingPrice:
                                  productModel!.products![index].sellingPrice!,
                              wishlistCount: productModel!
                                  .products![index].wishlistCount!);
                        },
                      ),
                    ),
                  ),
                ),
    );
  }
}
