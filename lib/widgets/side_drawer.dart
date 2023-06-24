import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final myCategories = ShopwareApiHelper().getMainNavigation();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FlutWare',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                      ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: const Text(
              'Categories',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: myCategories,
                builder: (ctx, snapshot) {
                  if (snapshot.data == null) {
                    return const Text('Waiting for Data');
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]['name'].toString()),
                          onTap: () {},
                        );
                      },);
                },),
          ),
        ],
      ),
    );
  }
}
