import 'package:flutter/material.dart';
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
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      MainPillButton(
                        activeElement: 'left',
                        textLeft: 'More',
                        textRight: 'Profile',
                        navigateTo: MoreScreen(
                          navigatorKey: widget.navigatorKey,
                        ),
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
