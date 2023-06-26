import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.orderNumber,
    required this.decreaseOrder,
    required this.increasOrder,
    required this.addItemsToCart,
  });

  final int orderNumber;

  final Function decreaseOrder;
  final Function increasOrder;
  final Function addItemsToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* NOTE: Increase or Decrease Button */
        Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 244, 130, 70),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              )),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.transparent;
                        }
                        return const Color.fromARGB(255, 249, 185, 151);
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0)));
                      }),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      /* fixedSize: MaterialStateProperty
                                                  .resolveWith<Size>((states) =>
                                                      const Size(30, 30)), */
                      ),
                  onPressed: () => decreaseOrder(),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 30,
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'x$orderNumber',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.transparent;
                          }
                          return const Color.fromARGB(255, 241, 105, 33);
                        }),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (_) {
                          return const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)));
                        }),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    onPressed: () => increasOrder(),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
              ]),
        ),
        /* NOTE: Order Button */
        TextButton(
          onPressed: () => addItemsToCart(),
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (states) => const EdgeInsets.only(left: 40, right: 40)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)));
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.transparent;
              }
              return const Color.fromARGB(255, 241, 105, 33);
            }),
          ),
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [],
            ),
          ),
        ),
      ],
    );
  }
}
