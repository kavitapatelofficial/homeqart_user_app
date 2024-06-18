import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeqartapp/screens/splash_screen.dart';
import 'package:homeqartapp/theme.dart';
import 'helper/get_storage_helper.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.accentDarkGrey, // navigation bar color
      statusBarColor: AppColor.primaryColor, // status bar color
    ),
  );
  await GetStorage.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //  implement initState
    GetStorageHelper.setinitialdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homeqart',
      home: SplashScreen(),
    );
  }
}
