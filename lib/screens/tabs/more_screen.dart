import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/profile_screen.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/search_screen.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key, required this.navigatorKey});

  final GlobalKey navigatorKey;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
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
              body: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 223, 225),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text('Demo3'),
                        )
                      ],
                    ),
                  ),
                  /* NOTE: Main Pill Navigation */
                  const Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      MainPillButton(
                        activeElement: 'left',
                        textLeft: 'More',
                        textRight: 'Profile',
                        navigateTo: ProfileScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
