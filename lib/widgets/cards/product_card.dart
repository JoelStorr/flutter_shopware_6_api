import 'dart:ffi';

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
      child: Row(children: []),
    ));
  }
}
