import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/screens/profile/components/section.dart';
import 'package:homeqartapp/screens/profile/components/user_profile_widget.dart';
import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Profile'),
      backgroundColor: AppColor.accentBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                UserProfileWidget(
                  userImageUrl: "${box.read('user_image')}",
                  userName: "${box.read('name')}",
                  userId: "${box.read('id')}",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Section(),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
