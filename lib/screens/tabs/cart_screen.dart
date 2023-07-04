import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/screens/subScreens/search_screen.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';
import 'package:flutter_shopware_6_api/widgets/cards/cart_item_card.dart';

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
                    FutureBuilder(
                      future: ShopwareApiHelper()
                          .createCart(contextToken: contextToken),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 241, 105, 33)));
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text('No Items in Cart'),
                          );
                        } else {
                          return SizedBox(
                            /* width: double.infinity, */
                            height: MediaQuery.of(context).size.height,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!['lineItems'].length,
                                  itemBuilder: (ctx, index) {
                                    if (index == 0) {
                                      return Column(
                                          /* mainAxisSize: MainAxisSize.min, */
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            CartItemCard(
                                                id: snapshot.data!['lineItems']
                                                    [index]['id'],
                                                name: snapshot.data!['lineItems']
                                                    [index]['label'],
                                                imageUrl: snapshot.data!['lineItems']
                                                    [index]['cover']['url'],
                                                weight: snapshot.data!['lineItems']
                                                        [index]['deliveryInformation']
                                                    ['weight'],
                                                price: snapshot.data!['lineItems'][index]
                                                    ['price']['unitPrice'],
                                                avilableStock: snapshot
                                                        .data!['lineItems'][index]
                                                    ['deliveryInformation']['stock'],
                                                amount: snapshot.data!['lineItems'][index]['quantity'])
                                          ]);
                                    }

                                    if (index ==
                                        snapshot.data!['lineItems'].length -
                                            1) {
                                      return Column(

                                          /* mainAxisSize: MainAxisSize.min, */
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CartItemCard(
                                                id: snapshot.data!['lineItems']
                                                    [index]['id'],
                                                name: snapshot.data!['lineItems']
                                                    [index]['label'],
                                                imageUrl: snapshot.data!['lineItems']
                                                    [index]['cover']['url'],
                                                weight: snapshot.data!['lineItems']
                                                        [index]['deliveryInformation']
                                                    ['weight'],
                                                price: snapshot.data!['lineItems'][index]
                                                    ['price']['unitPrice'],
                                                avilableStock: snapshot
                                                        .data!['lineItems'][index]
                                                    ['deliveryInformation']['stock'],
                                                amount: snapshot.data!['lineItems'][index]['quantity']),
                                            const SizedBox(
                                              height: 200,
                                            )
                                          ]);
                                    }

                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CartItemCard(
                                          id: snapshot.data!['lineItems'][index]
                                              ['id'],
                                          name: snapshot.data!['lineItems']
                                              [index]['label'],
                                          imageUrl: snapshot.data!['lineItems']
                                              [index]['cover']['url'],
                                          weight: snapshot.data!['lineItems']
                                                  [index]['deliveryInformation']
                                              ['weight'],
                                          price: snapshot.data!['lineItems']
                                              [index]['price']['unitPrice'],
                                          avilableStock: snapshot
                                                  .data!['lineItems'][index]
                                              ['deliveryInformation']['stock'],
                                          amount: snapshot.data!['lineItems']
                                              [index]['quantity'],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.white,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        const Text('Sub total:'),
                                        Text(
                                            '${snapshot.data!['price']['netPrice']}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Shipping:'),
                                        Text(
                                            '${snapshot.data!['deliveries'][0]['shippingCosts']['totalPrice']}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            'Tax(${snapshot.data!['price']['calculatedTaxes'][0]['taxRate']}%):'),
                                        Text(
                                            '${snapshot.data!['price']['calculatedTaxes'][0]['price']}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Total:'),
                                        Text(
                                            '${snapshot.data!['price']['totalPrice']}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                          (states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return Colors.transparent;
                                                }
                                                return const Color.fromARGB(
                                                    255, 241, 105, 33);
                                              }),
                                            ),
                                            onPressed: () {},
                                            child: const Row(
                                              children: [
                                                Text(
                                                  'Order now',
                                                  style: TextStyle(
                                                      color: Colors.white,),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                    Icons
                                                        .local_shipping_outlined,
                                                    color: Colors.white,),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ]),
                                )
                              ],
                            ),
                          );
                        }
                      },
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
