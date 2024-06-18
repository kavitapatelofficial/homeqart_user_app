import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
      title: Text(
        title,
        style: Texttheme.subTitle.copyWith(color: AppColor.accentDarkGrey),
      ),
      backgroundColor: AppColor.accentWhite,
      automaticallyImplyLeading: true,
    );
  }
}
