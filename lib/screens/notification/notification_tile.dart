import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';

class NotificationTile extends StatelessWidget {
  final String heading;
  final String description;
  final String time;
  const NotificationTile(
      {Key? key,
      required this.heading,
      required this.description,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColor.accentWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Icon(Icons.message),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Texttheme.subTitle.copyWith(color: AppColor.accentDarkGrey),
          ),
          Text(
            time,
            style: Texttheme.caption1.copyWith(color: AppColor.accentLightGrey),
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          description,
          maxLines: 2,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          style: Texttheme.bodyText2.copyWith(color: AppColor.accentLightGrey),
        ),
      ),
    );
  }
}
