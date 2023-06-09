import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.title,
      required this.imageLink,
      required this.categoryId});

  final String title;
  final String imageLink;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Color.fromARGB(255, 224, 223, 225),
        border: Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide.none,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(137, 70, 70, 70),
            offset: Offset(1.0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            imageLink,
            width: 60,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 77, 75, 76)),
                  )),
              TextButton(
                onPressed: () {},
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
                child: const Text(
                  'Get a Taste',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                            color: Color.fromARGB(137, 70, 70, 70),
                            offset: Offset(1.0, 2.0),
                            blurRadius: 2.0)
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
