import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/home.dart';
import 'package:flutter_shopware_6_api/screens/cart_screen.dart';
import 'package:flutter_shopware_6_api/screens/more_screen.dart';
import 'package:flutter_shopware_6_api/widgets/side_drawer.dart';

import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  //Handles Index Chnage
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Sets the current Widget based on the Selected index value
    Widget activePage = const HomeScreen();
    var activePageTitle = 'Home';
    String _textLeft = 'Latest';
    String _textRight = 'Last Orders';
    String _pillPosition = 'left';

    if (_selectedPageIndex == 0) {
      activePage = const HomeScreen();
      activePageTitle = 'Home';
      _textLeft = 'Latest';
      _textRight = 'Last Orders';
      _pillPosition = 'left';
    } else if (_selectedPageIndex == 1) {
      activePage = const CartScreen();
      activePageTitle = 'Cart';
      _textLeft = 'Home';
      _textRight = 'Cart';
      _pillPosition = 'right';
    } else if (_selectedPageIndex == 2) {
      activePage = const MoreScreen();
      activePageTitle = 'More';
      _textLeft = 'Home';
      _textRight = 'More';
      _pillPosition = 'right';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
            padding: const EdgeInsets.only(right: 30.0),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MainPillButton(
              activeElement: _pillPosition,
              textLeft: _textLeft,
              textRight: _textRight,
            ),
            activePage,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          ]),
    );
  }
}
