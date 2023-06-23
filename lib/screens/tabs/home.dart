import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/category_screen.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/last_orders_screen.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/product_screen.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/search_screen.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/cards/category_card.dart';
import 'package:flutter_shopware_6_api/widgets/cards/new_product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigatorKey});

  final GlobalKey navigatorKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final url = Uri.https('localhost', 'store-api/navigation/main-navigation');

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainNavigation = ShopwareApiHelper().getMainNavigation();
    final latestProduct = ShopwareApiHelper().getProductsForCategory('Latest');

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
                        FutureBuilder(
                          future: latestProduct,
                          builder: (ctx, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox(
                                height: 0.5,
                              );
                            }
                            return SizedBox(
                              height: 230,
                              child: Scrollbar(
                                thumbVisibility: true,
                                controller: _scrollController,
                                child: ListView.separated(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data![index]
                                            .containsKey('properties') &&
                                        snapshot.data![index]['properties']
                                                .length >
                                            0) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return ProductScreen(
                                                  productId: snapshot
                                                      .data![index]['id'],
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: NewProductCard(
                                          id: snapshot.data![index]['id'],
                                          name: snapshot.data![index]
                                              ['translated']['name'],
                                          imageURL: snapshot.data![index]
                                              ['cover']['media']['url'],
                                          buttonColor: snapshot.data![index]
                                              ['properties'][0]['colorHexCode'],
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return ProductScreen(
                                                  productId: snapshot
                                                      .data![index]['id'],
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: NewProductCard(
                                          id: snapshot.data![index]['id'],
                                          name: snapshot.data![index]
                                              ['translated']['name'],
                                          imageURL: snapshot.data![index]
                                              ['cover']['media']['url'],
                                        ),
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 10,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        /* FutureBuilder(builder: (){}), */

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 110,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(137, 70, 70, 70),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 2.0)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/taste_your_progress_banner_orange.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        FutureBuilder(
                          future: mainNavigation,
                          builder: (ctx, snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                heightFactor: 50.0,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.all(20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return CategoryScreen(
                                            categoryID: snapshot.data![index]
                                                ['id'],
                                            categoryName: snapshot.data![index]
                                                    ['breadcrumb'][1]
                                                .toString(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: CategoryCard(
                                    title: snapshot.data![index]['breadcrumb']
                                            [1]
                                        .toString(),
                                    imageLink: snapshot.data![index]['media']
                                        ['url'],
                                    categoryId: snapshot.data![index]['id'],
                                  ),
                                );
                              },
                            );
                          },
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
                        textLeft: 'Home',
                        textRight: 'Last Orders',
                        navigateTo: const LastOrdersScreen(),
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
