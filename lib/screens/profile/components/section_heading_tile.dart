import 'package:flutter/cupertino.dart';
import '../../../text_theme.dart';
import '../../../theme.dart';

class SectionHeadingTile extends StatelessWidget {
  final String heading;
  const SectionHeadingTile({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: AppColor.primaryColor.withOpacity(0.1),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Text(
              heading,
              style: Texttheme.title.copyWith(color: AppColor.primaryColor),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      )),
    );
  }
}
