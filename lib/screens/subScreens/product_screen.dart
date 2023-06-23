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
                        return const Placeholder();
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
