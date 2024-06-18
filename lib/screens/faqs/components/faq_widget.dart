import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import '../../../theme.dart';

class FaqWidget extends StatefulWidget {
  final String heading;
  final String description;
  const FaqWidget({Key? key, required this.heading, required this.description})
      : super(key: key);

  @override
  _FaqWidgetState createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: AppColor.accentWhite),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  iconColor: AppColor.primaryColor,
                  alignment: Alignment.center,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    widget.heading,
                    style: Texttheme.bodyText1,
                  ),
                ),
                collapsed: Container(),
                expanded: Column(
                  children: [
                    const Divider(),
                    Text(
                      widget.description,
                      textAlign: TextAlign.justify,
                      style: Texttheme.bodyText2.copyWith(
                        color: AppColor.accentLightGrey,
                      ),
                    ),
                  ],
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
