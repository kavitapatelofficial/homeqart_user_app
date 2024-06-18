import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  Widget floatingButton() {
    return SizedBox(
      height: 70,
      width: 65,
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
          size: 26.67,
        ),
        backgroundColor: const Color(0xff00B4D8),
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue.shade100, width: 0.5),
          backgroundBlendMode: BlendMode.clear,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.black,
              selectedItemColor: const Color(0xff00B4D8),
              currentIndex: index,
              onTap: (index) {
                setState(() {
                  this.index = index;
                });
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  title: Text('Home',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  title: Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.analytics_outlined),
                  title: Wrap(
                    spacing: 4,
                    children: [
                      const Text('Cart',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Container(
                        height: 21,
                        width: 21,
                        padding: const EdgeInsets.all(0.5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff00B4D8)),
                        child: const Text(
                          '3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  title: Text('Wishlist',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/images/account.png'),
                    ),
                  ),
                  title: const Text('Account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ]),
        ),
      ),
    );
  }
}
