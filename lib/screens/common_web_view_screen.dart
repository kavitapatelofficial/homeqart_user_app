import 'package:flutter/material.dart';
import 'package:homeqartapp/components/appbar_without_actions.dart';
import 'package:homeqartapp/models/response/policy_model.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:homeqartapp/theme.dart';
import 'package:flutter_html/flutter_html.dart';

class CommonWebViewScreen extends StatefulWidget {
  final String appBarTitle;
  final int index;
  const CommonWebViewScreen(
      {Key? key, required this.appBarTitle, required this.index})
      : super(key: key);

  @override
  _CommonWebViewScreenState createState() => _CommonWebViewScreenState();
}

class _CommonWebViewScreenState extends State<CommonWebViewScreen> {
  bool isLoading = true;
  BaseClient baseClient = BaseClient();
  List<PolicyModel> policyModel = [];

  getPolicy() async {
    final apiResponse = await baseClient.get(
        false, "https://homeqart.com", "/api/v1/privacy-policy");
    print(apiResponse);
    policyModel = welcomeFromJson(apiResponse);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    //  implement initState
    getPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar(widget.appBarTitle),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Html(
                data: policyModel[widget.index].value,
                style: {
                  'html': Style(),
                  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                  'p': Style(
                    fontSize: const FontSize(15),
                    textAlign: TextAlign.justify,
                  ),
                  'strong': Style(
                    fontWeight: FontWeight.bold,
                    fontSize: const FontSize(15),
                  ),
                },
              )));
  }
}
