import 'package:flutter/material.dart';

import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final url = Uri.https('localhost', 'store-api/category');

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final myCategories = ShopwareApiHelper().getCategoreis();

    return FutureBuilder(
        future: myCategories,
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return const Text('Waiting for Data');
          }
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['name']),
                  );
                }),
          );
        });
  }
}
