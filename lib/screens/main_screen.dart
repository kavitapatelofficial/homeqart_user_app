import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:homeqartapp/screens/categories/categories_screen.dart';
import 'package:homeqartapp/screens/profile/profile_screen.dart';
import 'package:homeqartapp/screens/shopping_cart/shopping_cart_screen.dart';
import 'package:homeqartapp/screens/wishlist/wishlist_screen.dart';
import 'package:homeqartapp/theme.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  var children = const [
    Home(),
    ShoppingCartScreen(),
    CategoriesScreen(),
    WishlistScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  Widget floatingButton() {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        onPressed: () {
          _currentIndex = 2;
          setState(() {});
        },
        child: const Icon(
          Icons.apps,
          color: Colors.white,
          size: 26.67,
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      extendBody: true,
      body: children[_currentIndex],
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTapped,
              currentIndex: _currentIndex,
              backgroundColor: Colors.white,
              fixedColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.defaultBlackColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined,
                      color: _currentIndex == 0
                          ? AppColor.primaryColor
                          : AppColor.defaultBlackColor),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined,
                      color: _currentIndex == 1
                          ? AppColor.primaryColor
                          : AppColor.defaultBlackColor),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.analytics_outlined,
                    color: AppColor.accentWhite,
                  ),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                    color: _currentIndex == 3
                        ? AppColor.primaryColor
                        : AppColor.defaultBlackColor,
                  ),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 30,
                    height: 25,
                    child: CircleAvatar(
                      backgroundColor: AppColor.accentBgColor,
                      child: const Icon(Icons.person),
                    ),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
