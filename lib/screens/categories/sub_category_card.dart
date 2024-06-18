import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/category_model.dart';
import 'package:homeqartapp/screens/show_all_products/show_all_products_screen.dart';
import 'package:homeqartapp/services/base_client.dart';
import '../../text_theme.dart';
import '../../theme.dart';

class SubCategoryScreen extends StatefulWidget {
  final int subCaegoryId;
  final String categoryName;
  const SubCategoryScreen(
      {Key? key, required this.categoryName, required this.subCaegoryId})
      : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  bool isLoading = true;
  BaseClient baseClient = BaseClient();
  List<CategoryModel> categories = [];

  getCategories() async {
    var response = await baseClient.get(false, "https://homeqart.com",
        "/api/v1/categories/childes/${widget.subCaegoryId}");
    categories = categoryModelFromJson(response);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar(widget.categoryName),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // print(categories[index].image!);
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowAllProductsScreen(
                                  subCategoryName:
                                      categories[index].name.toString(),
                                  subCategoryId:
                                      categories[index].id.toString(),
                                );
                              }));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.accentWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://homeqart.com/storage/app/public/category/" +
                                                  categories[index].image!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Icon(
                                            Icons.photo,
                                            size: 50,
                                            color: AppColor.accentLightGrey,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.info,
                                            size: 50,
                                            color: AppColor.accentLightGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          155,
                                      child: Text(
                                        categories[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: Texttheme.subTitle.copyWith(
                                            color: AppColor.accentLightGrey),
                                      ),
                                    ),
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
            ),
    );
  }
}
