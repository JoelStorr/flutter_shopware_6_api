import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/tabs/home.dart';
import 'package:flutter_shopware_6_api/screens/tabs/cart_screen.dart';
import 'package:flutter_shopware_6_api/screens/tabs/more_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  //Handles Index Chnage
  int _selectedPageIndex = 0;

  Map<int, GlobalKey> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
  };

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return !await Navigator.maybePop(
                navigatorKeys[_selectedPageIndex]!.currentState!.context);
          },
          child: IndexedStack(
            index: _selectedPageIndex,
            children: [
              HomeScreen(
                navigatorKey: navigatorKeys[0]!,
              ),
              const CartScreen(),
              MoreScreen(
                navigatorKey: navigatorKeys[2]!,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        //TODO: Add return via Doule Tab on Bottom Nav bar
        onDoubleTap: () {},
        child: BottomNavigationBar(
          //Changes the Index
          onTap: (index) {
            _selectedPage(index);
          },

          //The currentIndex manages the highlight of the Selected Tab item
          currentIndex: _selectedPageIndex,
          //Sets the Navigation items in the Tab Bar
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color.fromARGB(255, 244, 130, 70),
          iconSize: 32,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'You'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps_rounded,
                ),
                label: 'More'),
          ],
        ),
      ),
    );
  }
}
