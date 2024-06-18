import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/get_faq_response.dart';
import 'package:homeqartapp/screens/faqs/components/faq_widget.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<GetFaqResponse> faqList = [];
  BaseClient baseClient = BaseClient();

  getFaq() async {
    var response =
        await baseClient.get(false, "https://homeqart.com", "/api/v1/faqs");
    faqList = getFaqResponseFromJson(response);
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getFaq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("FAQ"),
      backgroundColor: AppColor.accentBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: faqList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FaqWidget(
                    heading: faqList[index].question!,
                    description: faqList[index].answer!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
