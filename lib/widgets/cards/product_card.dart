import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(name),
    );
  }
}
