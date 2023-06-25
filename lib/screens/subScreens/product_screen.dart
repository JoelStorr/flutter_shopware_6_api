import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 100,
                ),
                FutureBuilder(
                    future: ShopwareApiHelper()
                        .getProduct(productID: widget.productId),
                    builder: (ctx, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text('No Products Found'),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              snapshot.data!['cover']['media']['url'],
                              height: 160,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      snapshot.data!['translated']['name'],
                                    ),
                                    Text(
                                      snapshot.data!['productReviews'] ??
                                          'Not yet Rated',
                                    )
                                  ],
                                ),
                                Text(
                                  "${snapshot.data!['calculatedPrice']['unitPrice']} €",
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text('size:'),
                                Text('${snapshot.data!['weight'] * 1000} g')
                              ],
                            ),
                            const Text('Description'),
                            Text(snapshot.data!['translated']['description']),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove)),
                                    Text('x1'),
                                    IconButton(
                                        onPressed: () {}, icon: Icon(Icons.add))
                                  ]),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    /*  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (states) {
                      return Padding(padding: EdgeInsets.all(0));
                    },
                  ), */
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>((_) {
                                      return const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomRight:
                                                  Radius.circular(5.0)));
                                    }),
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors.transparent;
                                      }
                                      return const Color.fromARGB(
                                          255, 244, 130, 70);
                                    }),
                                  ),
                                  child: const Text(
                                    'More Detailes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(137, 70, 70, 70),
                                            offset: Offset(1.0, 2.0),
                                            blurRadius: 2.0)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
                textRight: 'Item',
                navigateTo: ProductScreen(
                  productId: widget.productId,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
