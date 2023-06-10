import 'package:flutter/material.dart';

import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/widgets/cards/category_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final url = Uri.https('localhost', 'store-api/navigation/main-navigation');

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final myCategories = ShopwareApiHelper().getMainNavigation();

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 50,
          ),
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
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/taste_your_progress_banner_orange.png'),
                  fit: BoxFit.cover),
            ),
          ),
          FutureBuilder(
              future: myCategories,
              builder: (ctx, snapshot) {
                if (snapshot.data == null) {
                  return const Text('Waiting for Data');
                }
                return Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return CategoryCart(
                          title:
                              snapshot.data![index]['breadcrumb'][1].toString(),
                          imageLink: snapshot.data![index]['media']['url'],
                          categoryId: snapshot.data![index]['id'],
                        );

                        /* ListTile(
                          title: Text(snapshot.data![index]['breadcrumb'][1]
                              .toString()),
                        ); */
                      }),
                );
              }),
        ],
      ),
    );
  }
}
