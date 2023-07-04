import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'dart:ffi';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating});

  final String? rating;

  @override
  Widget build(BuildContext context) {
    double convertVal = 1.0;

    if (rating == null) {
      final double convertVal = double.parse(rating!);
    }

    if (rating == null) {
      return const Text(
        'Not yet rated',
        style: TextStyle(
          color: Color.fromARGB(
            204,
            40,
            40,
            40,
          ),
        ),
      );
    } else if (convertVal >= 0.0 && convertVal <= 1.0) {
      return const Text(
        'Not yet rated',
        style: TextStyle(
          color: Color.fromARGB(
            204,
            40,
            40,
            40,
          ),
        ),
      );
    } else if (convertVal >= 1.0 && convertVal <= 2.0) {
      return Row(
        children: [
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
        ],
      );
    } else if (convertVal >= 2.0 && convertVal <= 3.0) {
      return Row(
        children: [
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
        ],
      );
    } else if (convertVal >= 3.0 && convertVal <= 4.0) {
      return Row(
        children: [
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
        ],
      );
    } else if (convertVal >= 4.0 && convertVal <= 5.0) {
      return Row(
        children: [
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/empty_bean.png',
            width: 20,
            height: 20,
          ),
        ],
      );
    } else if (convertVal >= 5.0 && convertVal <= 6.0) {
      return Row(
        children: [
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
          Image.asset(
            './assets/images/rating_beans/full_bean.png',
            width: 20,
            height: 20,
          ),
        ],
      );
    } else {
      return const Text(
        'Not yet rated',
        style: TextStyle(
          color: Color.fromARGB(
            204,
            40,
            40,
            40,
          ),
        ),
      );
    }
  }
}
