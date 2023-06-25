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
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Colors.transparent;
                                            }
                                            return const Color.fromARGB(
                                                255, 249, 185, 151);
                                          }),
                                          shape: MaterialStateProperty
                                              .resolveWith<OutlinedBorder>((_) {
                                            return const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0)));
                                          }),
                                          fixedSize: MaterialStateProperty
                                              .resolveWith<Size>((states) =>
                                                  const Size(30, 30)),
                                        ),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        alignment: Alignment.center,
                                        color: const Color.fromARGB(
                                            255, 244, 130, 70),
                                        child: const Text(
                                          'x1',
                                          style: TextStyle(color: Colors.white),
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
                                                  255, 249, 185, 151);
                                            }),
                                            shape: MaterialStateProperty
                                                .resolveWith<OutlinedBorder>(
                                                    (_) {
                                              return const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0)));
                                            }),
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ))
                                    ]),
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
