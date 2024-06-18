import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/get_notifications_response.dart';
import 'package:homeqartapp/screens/notification/notification_tile.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<GetNotificationResponse> notificationList = [];
  BaseClient baseClient = BaseClient();

  getNotification() async {
    var response = await baseClient.get(
        false, "https://homeqart.com", "/api/v1/notifications");
    notificationList = getNotificationResponseFromJson(response);
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Notifications'),
      backgroundColor: AppColor.accentBgColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return NotificationTile(
                  heading: notificationList[index].title!,
                  description: notificationList[index].description!,
                  time: "10:30AM",
                );
              },
            )

            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 10),
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: Text(
            //           "Today",
            //           style: Texttheme.subTitle,
            //         ),
            //       ),
            //     ),
            //     const NotificationTile(
            //       heading: "Title for Notification",
            //       description:
            //           "Reference site about Lorem Ipsum, giving information on its origins...",
            //       time: "10:45AM",
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     const NotificationTile(
            //       heading: "Title for Notification",
            //       description:
            //           "Reference site about Lorem Ipsum, giving information on its origins...",
            //       time: "10:45AM",
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 10),
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: Text(
            //           "Yesterday",
            //           style: Texttheme.subTitle,
            //         ),
            //       ),
            //     ),
            //     const NotificationTile(
            //       heading: "Title for Notification",
            //       description:
            //           "Reference site about Lorem Ipsum, giving information on its origins...",
            //       time: "10:45AM",
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     const NotificationTile(
            //       heading: "Title for Notification",
            //       description:
            //           "Reference site about Lorem Ipsum, giving information on its origins...",
            //       time: "10:45AM",
            //     ),
            //   ],
            // ),
            ),
      )),
    );
  }
}
