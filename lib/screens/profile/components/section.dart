import 'package:flutter/material.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/screens/address/address_screen.dart';
import 'package:homeqartapp/screens/common_web_view_screen.dart';
import 'package:homeqartapp/screens/contact_us.dart';
import 'package:homeqartapp/screens/faqs/faq_screen.dart';
import 'package:homeqartapp/screens/orders/orders_screen.dart';
import 'package:homeqartapp/screens/profile/components/section_heading_tile.dart';
import 'package:homeqartapp/screens/profile/components/section_tile.dart';
import 'package:homeqartapp/screens/shopping_cart/shopping_cart_screen.dart';
import 'package:homeqartapp/screens/wishlist/wishlist_screen.dart';
import 'package:homeqartapp/theme.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import '../../../main.dart';

class Section extends StatelessWidget {
  const Section({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.accentWhite,
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              const SectionHeadingTile(heading: "General"),
              SectionTile(
                iconData: Icons.shopping_bag_outlined,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const OrdersScreen();
                  }));
                },
                tileText: "My Orders",
              ),
              SectionTile(
                iconData: Icons.favorite_outline,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const WishlistScreen();
                  }));
                },
                tileText: "Wishlist",
              ),
              SectionTile(
                iconData: Icons.location_city_outlined,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddressScreen(
                      appBarTitle: "Saved Addresses",
                    );
                  }));
                },
                tileText: "Address",
              ),
              SectionTile(
                iconData: Icons.shopping_cart_outlined,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ShoppingCartScreen();
                  }));
                },
                tileText: "Cart",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.accentWhite,
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              const SectionHeadingTile(heading: "More option"),
              SectionTile(
                iconData: Icons.question_answer_outlined,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FAQ();
                  }));
                },
                tileText: "FAQ",
              ),
              SectionTile(
                iconData: Icons.contact_support_sharp,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ContactUs();
                  }));
                },
                tileText: "Contact us",
              ),
              SectionTile(
                iconData: Icons.share,
                press: () {
                  Share.share(
                    'Hi Check this amazing app https://play.google.com/store/apps/details?id=com.HomeQart',
                  );
                },
                tileText: "Share with friends",
              ),
              SectionTile(
                iconData: Icons.reviews,
                press: () {
                  LaunchReview.launch(
                    androidAppId: "com.HomeQart",
                  );
                },
                tileText: "Write a review",
              ),
              SectionTile(
                iconData: Icons.privacy_tip_outlined,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CommonWebViewScreen(
                      appBarTitle: "Privacy Policy",
                      index: 1,
                    );
                  }));
                },
                tileText: "Privacy Policy",
              ),
              SectionTile(
                iconData: Icons.settings_backup_restore_sharp,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CommonWebViewScreen(
                      appBarTitle: "Return Policy",
                      index: 2,
                    );
                  }));
                },
                tileText: "Return Policy",
              ),
              SectionTile(
                iconData: Icons.ac_unit,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CommonWebViewScreen(
                      appBarTitle: "Terms and conditions",
                      index: 0,
                    );
                  }));
                },
                tileText: "Terms and conditions",
              ),
              SectionTile(
                iconData: Icons.logout,
                press: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (BuildContext context) {
                      box.erase();
                      return const MyApp();
                    },
                  ), (Route<dynamic> route) => false);
                },
                tileText: "Logout",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
