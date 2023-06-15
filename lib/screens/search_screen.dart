import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/cards/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  Timer? timer;
  Future<List<Map<dynamic, dynamic>>>? currentSearchProducts;

  performSearch(String value) {
    if (timer != null) {
      timer!.cancel();
    }
    if (value.trim().isEmpty) {
      return;
    }
    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        currentSearchProducts = ShopwareApiHelper().getSearchProducts(value);
      });
    });
  }

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
            onPressed: () {},
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
                  height: 200,
                ),
                currentSearchProducts != null
                    ? FutureBuilder(
                        future: currentSearchProducts,
                        builder: (ctx, snapshot) {
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No Products Found'),
                            );
                          } else {
                            return ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  id: snapshot.data![index]['id'],
                                  name: snapshot.data![index]['translated']
                                      ['name'],
                                  imageUrl: snapshot.data![index]['cover']
                                      ['media']['url'],
                                  ratingAverage: snapshot.data![index]
                                      ['ratingAverage'],
                                  weight: snapshot.data![index]['weight'],
                                  price: snapshot.data![index]
                                      ['calculatedPrice']['totalPrice'],
                                  available: snapshot.data![index]['available'],
                                  avilableStock: snapshot.data![index]
                                      ['availableStock'],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                            );
                          }
                        })
                    : const Center(
                        child: Text('Lets find something for you'),
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
                activeElement: 'right',
                textLeft: 'Home',
                textRight: 'Search',
                navigateTo: const SearchScreen(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _searchTextController,
                  maxLength: 100,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Search'),
                    focusColor: Color.fromARGB(255, 244, 130, 70),
                    fillColor: Color.fromARGB(255, 244, 130, 70),
                    hoverColor: Color.fromARGB(255, 244, 130, 70),
                  ),
                  onChanged: (value) => performSearch(value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
