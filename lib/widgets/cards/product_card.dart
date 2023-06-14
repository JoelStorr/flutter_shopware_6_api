import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ratingAverage,
    required this.weight,
    required this.price,
    required this.available,
    required this.avilableStock,
  });

  final String id;
  final String name;
  final String imageUrl;
  final Float? ratingAverage;
  final Float? weight;
  final double price;
  final bool available;
  final int avilableStock;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      child: Row(children: [
        Image.network(
          imageUrl,
          width: 100,
        ),
        Column(
          children: [
            Text(name),
            Text('$ratingAverage'),
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
                const Text('Avalible Placeholder'),
              ],
            ),
            Row(
              children: [],
            )
          ],
        )
      ]),
    ));
  }
}
