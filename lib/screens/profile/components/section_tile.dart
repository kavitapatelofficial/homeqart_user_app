import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class SectionTile extends StatelessWidget {
  final IconData iconData;
  final String tileText;
  final VoidCallback press;
  const SectionTile(
      {Key? key,
      required this.iconData,
      required this.press,
      required this.tileText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Icon(
                iconData,
                color: AppColor.accentDarkGrey,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                tileText,
                style: Texttheme.subTitle,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
