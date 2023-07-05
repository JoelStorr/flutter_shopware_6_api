import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/search_screen.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

class LastOrdersScreen extends StatelessWidget {
  const LastOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Image.asset(
          'assets/images/logo/Logo.png',
          width: 200,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SearchScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
            padding: const EdgeInsets.only(right: 30.0),
          ),
        ],
      ),
      body: const Stack(
        children: [
          //TODO: Implement Future Builder for Bought items

          /* FutureBuilder(builder: (ctx, snapshot) {
            return const Text('demo');
          }), */
          Center(
            child: Text('No Orders yet'),
          ),
          /* NOTE: Main Pill Button */
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              MainPillButton(
                activeElement: 'right',
                textLeft: 'Home',
                textRight: 'Last Orders',
                navigateTo: LastOrdersScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
