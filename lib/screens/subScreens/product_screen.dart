import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/product_detail/order_buttons.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key, required this.productId});

  String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: ShopwareApiHelper()
                          .getProduct(productID: widget.productId),
                      builder: (ctx, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text('No Products Found'),
                          );
                        } else {
                          return Stack(
                            children: [
                              SingleChildScrollView(
                                primary: true,
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* NOTE: Main Image */
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          snapshot.data!['cover']['media']
                                              ['url'],
                                          height: 160,
                                        ),
                                      ],
                                    ),
                                    /* NOTE: Name, Rating and Price */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!['translated']
                                                  ['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![
                                                      'productReviews'] ??
                                                  'Not yet Rated',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data!['calculatedPrice']['unitPrice']} €",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    /* NOTE: Product Size */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Size',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data!['weight'] * 1000} g',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    /* NOTE: Product Description */
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(snapshot.data!['translated']
                                        ['description']),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OrderButton(),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MainPillButton(
                  activeElement: 'right',
                  textLeft: 'Home',
                  textRight: 'Item',
                  navigateTo: ProductScreen(
                    productId: widget.productId,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
