import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/category_model.dart';
import 'package:homeqartapp/screens/categories/sub_category_card.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';
import '../../text_theme.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  BaseClient baseClient = BaseClient();
  List<CategoryModel> categories = [];

  getCategories() async {
    var response = await baseClient.get(
        false, "https://homeqart.com", "/api/v1/categories");
    categories = categoryModelFromJson(response);
    setState(() {});
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Categories"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                          return SubCategoryScreen(
                              subCaegoryId: categories[index].id!,
                              categoryName: categories[index].name!);
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: AppColor.accentWhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
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
                                    errorWidget: (context, url, error) => Icon(
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
                                width: MediaQuery.of(context).size.width - 155,
                                child: Text(
                                  categories[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Texttheme.subTitle.copyWith(
                                      color: AppColor.accentLightGrey),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: AppColor.accentLightGrey,
                                size: 15,
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
      ),
    );
  }
}
