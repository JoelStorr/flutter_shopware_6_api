import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/home.dart';
import 'package:flutter_shopware_6_api/screens/cart_screen.dart';
import 'package:flutter_shopware_6_api/screens/more_screen.dart';
import 'package:flutter_shopware_6_api/widgets/side_drawer.dart';

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

    if (_selectedPageIndex == 0) {
      activePage = const HomeScreen();
      activePageTitle = 'Home';
    } else if (_selectedPageIndex == 1) {
      activePage = const CartScreen();
      activePageTitle = 'Cart';
    } else if (_selectedPageIndex == 2) {
      activePage = const MoreScreen();
      activePageTitle = 'More';
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
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          //Changes the Index
          onTap: (index) {
            _selectedPage(index);
          },
          //The currentIndex manages the highlight of the Selected Tab item
          currentIndex: _selectedPageIndex,
          //Sets the Navigation items in the Tab Bar
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'You'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.reorder,
                ),
                label: 'More'),
          ]),
    );
  }
}
