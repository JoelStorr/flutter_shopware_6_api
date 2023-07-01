import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/search_screen.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key, required this.navigatorKey});

  final GlobalKey navigatorKey;

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final contextToken = ref.watch(authProvider);
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
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          FutureBuilder(
                            future: ShopwareApiHelper()
                                .createCart(contextToken: contextToken),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(255, 241, 105, 33)));
                              } else if (snapshot.data == null) {
                                return const Center(
                                  child: Text('No Items in Cart'),
                                );
                              } else {
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data!['lineItems'].length,
                                        itemBuilder: (ctx, index) {
                                          return const Placeholder();
                                        },
                                      ),
                                      const SizedBox(
                                        height: 200,
                                      ),
                                      const SizedBox(
                                        height: 100,
                                        child: Text('Demo'),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        MainPillButton(
                          activeElement: 'right',
                          textLeft: 'Home',
                          textRight: 'Cart',
                          navigateTo:
                              CartScreen(navigatorKey: widget.navigatorKey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
