import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/product_detail/order_buttons.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var orderNumber = 1;

  increasOrder() {
    setState(() {
      orderNumber++;
    });
  }

  decreaseOrder() {
    if (orderNumber == 1) {
      return;
    } else {
      setState(() {
        orderNumber--;
      });
    }
  }

  addItemsToCart() {}

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
                                    const SizedBox(
                                      height: 20,
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
                                                  color: Color.fromARGB(
                                                    204,
                                                    40,
                                                    40,
                                                    40,
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              snapshot.data![
                                                      'productReviews'] ??
                                                  'Not yet Rated',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                  204,
                                                  40,
                                                  40,
                                                  40,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data!['calculatedPrice']['unitPrice']} €",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Color.fromARGB(
                                              204,
                                              40,
                                              40,
                                              40,
                                            ),
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
                                            fontSize: 25,
                                            color: Color.fromARGB(
                                              204,
                                              40,
                                              40,
                                              40,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data!['weight'] * 1000} g',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                              204,
                                              40,
                                              40,
                                              40,
                                            ),
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
                                        color: Color.fromARGB(
                                          204,
                                          40,
                                          40,
                                          40,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!['translated']
                                          ['description'],
                                      style: const TextStyle(
                                        color: Color.fromARGB(
                                          204,
                                          40,
                                          40,
                                          40,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OrderButton(
                                      orderNumber: orderNumber,
                                      increasOrder: increasOrder,
                                      decreaseOrder: decreaseOrder,
                                      addItemsToCart: addItemsToCart,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
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
