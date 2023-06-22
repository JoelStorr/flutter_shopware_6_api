import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';
import 'package:flutter_shopware_6_api/widgets/buttons/main_pill_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final contextToken = ref.watch(authProvider);

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
                    //TODO: Make Profile Request
                    future: ShopwareApiHelper()
                        .checkCustomer(contextToken: contextToken),
                    builder: (ctx, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text('Could not get the data'),
                        );
                      }

                      return Column(
                        children: [
                          Text('Hello,${snapshot.data!['firstName']}'),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Personal'),
                          GridView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            children: [
                              SizedBox(
                                height: 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('First Name'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!['firstName'],
                                    ),
                                    const Divider(
                                      indent: 5.0,
                                      color: Colors.black12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    const Text('Last Name'),
                                    Text(snapshot.data!['lastName']),
                                  ],
                                ),
                              ),
                              //TODO: Fix Salutation
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    const Text('Salutation'),
                                    Text(snapshot.data!['salutation']
                                        ['salutationKey']),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    const Text('Age'),
                                    Text(snapshot.data!['birthday'] ??
                                        'Placeholder'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Adress'),
                          GridView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            children: [
                              SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    Text('Street'),
                                    Text(snapshot.data!['street'])
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    Text('Zip Code'),
                                    Text(snapshot.data!['zipcode'])
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    Text('City'),
                                    Text(snapshot.data!['city'])
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Column(
                                  children: [
                                    Text('Country'),
                                    Text(snapshot.data!['country']['name'])
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      );
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
                textLeft: 'More',
                textRight: 'Profile',
                navigateTo: const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
