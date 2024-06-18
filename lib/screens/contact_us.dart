import 'package:flutter/material.dart';
import 'package:homeqartapp/text_theme.dart';
import 'package:homeqartapp/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: const Text(
        "Connect With Us",
        // style: TextStyle(fontSize: 16, color: AppColor.accentDarkGrey),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.accentWhite,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Image.asset('assets/images/5133405-removebg-preview.png'),
                const Divider(),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.message_outlined),
                  ),
                  title: Text(
                    'Chat With Custmer Service',
                    style: Texttheme.bodyText1,
                  ),
                  subtitle: Text(
                    'Monday - Sunday : 10:00 AM - 07:00PM',
                    style: Texttheme.bodyText2,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await canLaunch('tel:8434398719')
                        ? await launch('tel:8434398719')
                        : throw 'Could not launch';
                  },
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.call_outlined),
                  ),
                  title: Text(
                    'Call Us',
                    style: Texttheme.bodyText1,
                  ),
                  subtitle: Text(
                    'Monday - Sunday : 10:00 AM - 07:00PM',
                    style: Texttheme.bodyText2,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    if (await canLaunch("mailto:mandalamit455@gmail.com")) {
                      await launch("mailto:mandalamit455@gmail.com");
                    } else {
                      throw 'Could not launch';
                    }
                  },
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.email_outlined),
                  ),
                  title: Text(
                    'Email Us',
                    style: Texttheme.bodyText1,
                  ),
                  subtitle: Text(
                    '24x7 Available',
                    style: Texttheme.bodyText2,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    if (await canLaunch(
                        "https://api.whatsapp.com/send?phone=918434398719&text=&source=&data=&app_absent=")) {
                      await launch(
                          "https://api.whatsapp.com/send?phone=918434398719&text=&source=&data=&app_absent=");
                    } else {
                      throw 'Could not launch';
                    }
                  },
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.chat_bubble_outline_rounded),
                  ),
                  title: Text(
                    'Live Chat',
                    style: Texttheme.bodyText1,
                  ),
                  subtitle: Text(
                    'Monday - Sunday : 10:00 AM - 07:00PM',
                    style: Texttheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
