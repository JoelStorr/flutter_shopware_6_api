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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* NOTE: Main Image */
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  snapshot.data!['cover']['media']['url'],
                                  height: 160,
                                ),
                              ],
                            ),
                            /* NOTE: Name, Rating and Price */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!['translated']['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!['productReviews'] ??
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const Text('Description'),
                            Text(snapshot.data!['translated']['description']),
                            /* NOTE: Buttons */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* NOTE: Increase or Decrease Button */
                                Container(
                                  padding: const EdgeInsets.all(0),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 244, 130, 70),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0),
                                      )),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          padding: const EdgeInsets.all(0),
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
                                                    255, 249, 185, 151);
                                              }),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                      (_) {
                                                return const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5.0)));
                                              }),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap
                                              /* fixedSize: MaterialStateProperty
                                                .resolveWith<Size>((states) =>
                                                    const Size(30, 30)), */
                                              ),
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'x1',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        IconButton(
                                            padding: const EdgeInsets.all(0),
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
                                                shape: MaterialStateProperty
                                                    .resolveWith<
                                                        OutlinedBorder>((_) {
                                                  return const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0)));
                                                }),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap),
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ))
                                      ]),
                                ),
                                /* NOTE: Order Button */
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
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [],
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
