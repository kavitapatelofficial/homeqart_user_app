import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/screens/categories/category_card.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class CauseCardGrid extends StatelessWidget {
  final String imageUrl;
  final String name;
  const CauseCardGrid({Key? key, required this.imageUrl, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: AppColor.accentWhite, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  alignment: Alignment.center,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              "https://homeqart.com/storage/app/public/category/" +
                                  imageUrl),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 155,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: Texttheme.subTitle
                              .copyWith(color: AppColor.accentLightGrey),
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(),
                expanded: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      mainAxisExtent: 120,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, index) {
                      return const CategoryCard(
                          imageUrl: "https://picsum.photos/200/300",
                          cause: "Fruit");
                    },
                  ),
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
