import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/product_screen.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/cards/product_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categoryID,
    required this.categoryName,
  });

  final String categoryID;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final currentCategoryProducts =
        ShopwareApiHelper().getProductsForCategoryID(categoryID);

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
                  height: 100,
                ),
                FutureBuilder(
                    future: currentCategoryProducts,
                    builder: (ctx, snapshot) {
                      if (snapshot.data == null) {
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
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ProductScreen(
                                        productId: snapshot.data![index]['id'],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ProductCard(
                                id: snapshot.data![index]['id'],
                                name: snapshot.data![index]['translated']
                                    ['name'],
                                imageUrl: snapshot.data![index]['cover']
                                    ['media']['url'],
                                ratingAverage: snapshot.data![index]
                                    ['ratingAverage'],
                                weight: snapshot.data![index]['weight'],
                                price: snapshot.data![index]['calculatedPrice']
                                    ['totalPrice'],
                                available: snapshot.data![index]['available'],
                                avilableStock: snapshot.data![index]
                                    ['availableStock'],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                        );
                      }
                    }),
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
                textRight: categoryName,
                navigateTo: CategoryScreen(
                  categoryID: categoryID,
                  categoryName: categoryName,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
