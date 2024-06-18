import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/models/response/login_response.dart';
import 'package:homeqartapp/services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../text_theme.dart';
import '../../../theme.dart';

class UserProfileWidget extends StatefulWidget {
  final String userName;
  final String userId;
  final String userImageUrl;
  const UserProfileWidget(
      {Key? key,
      required this.userName,
      required this.userId,
      required this.userImageUrl})
      : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  File? selectedImage;
  BaseClient baseClient = BaseClient();
  LoginResponse? loginResponse;
  // This function used to pick image from device
  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      selectedImage = File(image.path);
      final apiResponse = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          uploadImage(selectedImage!),
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

// This function show option to pick either from the camera or gallery
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    await pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  await pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  uploadImage(File image) async {
    print(widget.userId);
    var headers = {'Authorization': 'Bearer ${box.read('access_token')}'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://homeqart.com/api/v1/customer/update-profile-picture'));
    request.fields.addAll({'user_id': widget.userId});
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final apiResponse = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(getUserProfile()),
      );
    } else {}
  }

  getUserProfile() async {
    final response = await baseClient.get(
        true, "https://homeqart.com", "/api/v1/customer/info");
    var userdata = jsonDecode(response);
    box.write("id", userdata['id']);
    box.write("name", userdata['name']);
    box.write("email", userdata['email']);
    box.write("phone", userdata['phone']);
    box.write("user_image", userdata['image']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColor.accentWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: AppColor.primaryColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://homeqart.com/storage/app/public/user/" +
                                  widget.userImageUrl.toString(),
                          placeholder: (context, url) => Icon(
                            Icons.photo,
                            size: 50,
                            color: AppColor.accentLightGrey,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            size: 50,
                            color: AppColor.accentLightGrey,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        _showPicker(context);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.primaryColor,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.userName,
                style: Texttheme.subTitle,
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check_circle,
                color: AppColor.primaryColor,
                size: 20,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Phone: ${box.read("phone")}",
            style:
                Texttheme.bodyText1.copyWith(color: AppColor.accentLightGrey),
          ),
          Text(
            "Email: ${box.read("email")}",
            style:
                Texttheme.bodyText1.copyWith(color: AppColor.accentLightGrey),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
