import 'dart:ui';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.weight,
    required this.price,
    required this.avilableStock,
    required this.amount,
  });

  final String id;
  final String name;
  final String imageUrl;

  final double? weight;
  final double price;

  final int avilableStock;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 223, 225),
          borderRadius: BorderRadius.circular(5.0),
          border: const Border.symmetric(
            vertical: BorderSide.none,
            horizontal: BorderSide.none,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(137, 70, 70, 70),
                offset: Offset(1.0, 2.0),
                blurRadius: 2.0),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                imageUrl,
                width: 75,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            204,
                            40,
                            40,
                            40,
                          ),
                        ),
                      ),
                      //TODO: Make ratin Widget
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(500),
                          ),
                          color: Colors.green,
                        ),
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      avilableStock > 0
                          ? const Text(
                              'Available',
                              style: TextStyle(
                                color: Color.fromARGB(
                                  204,
                                  40,
                                  40,
                                  40,
                                ),
                              ),
                            )
                          : const Text(
                              'Back soon',
                              style: TextStyle(
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              weight == null
                  ? const Text('')
                  : Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Text(
                        '${(weight! * 1000).toInt()} g',
                        style: const TextStyle(
                          color: Color.fromARGB(
                            204,
                            40,
                            40,
                            40,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Price:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                          204,
                          40,
                          40,
                          40,
                        ),
                      ),
                    ),
                    Text(
                      '$price €',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
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
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  /* Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProductScreen(
                          productId: id,
                        );
                      },
                    ),
                  ); */
                },
                style: ButtonStyle(
                  /*  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (states) {
                      return Padding(padding: EdgeInsets.all(0));
                    },
                  ), */
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0)));
                  }),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.transparent;
                    }
                    return const Color.fromARGB(255, 244, 130, 70);
                  }),
                ),
                child: Text(
                  '$amount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                          color: Color.fromARGB(137, 70, 70, 70),
                          offset: Offset(1.0, 2.0),
                          blurRadius: 2.0)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
