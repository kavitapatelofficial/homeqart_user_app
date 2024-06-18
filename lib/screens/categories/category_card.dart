import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import '../../theme.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String cause;
  const CategoryCard({Key? key, required this.imageUrl, required this.cause})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(.2),
            offset: const Offset(3.72, 7.43),
            blurRadius: 18.5,
          )
        ],
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 80,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            cause,
            style: Texttheme.bodyText1,
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:homeqartapp/text_theme.dart';
// import 'package:homeqartapp/theme.dart';

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColor.accentWhite,
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               'https://picsum.photos/200/300',
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: Text(
//                 "Fresh Fruits",
//                 style: Texttheme.bodyText1,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
