import 'package:flutter/material.dart';

//Code from Stack Overflow
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class NewProductCard extends StatelessWidget {
  const NewProductCard(
      {super.key,
      required this.id,
      required this.name,
      required this.imageURL,
      this.buttonColor});

  final String id;
  final String name;
  final String imageURL;
  final String? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Container(
              width: 180,
              height: 160,
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
                        blurRadius: 2.0),
                  ]),
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 62,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Color.fromARGB(200, 40, 38, 38),
                      ),
                    ),
                    const Text('rating placeholder'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>((_) {
                              return const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0)));
                            }),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.transparent;
                              }
                              if (buttonColor == null) {
                                return const Color.fromARGB(255, 244, 130, 70);
                              } else {
                                return HexColor.fromHex(buttonColor!);
                              }
                            }),
                          ),
                          child: const Text(
                            'Get a Tatse',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                      color: Color.fromARGB(137, 70, 70, 70),
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 2.0),
                                ]),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ],
        ),
        Image.network(
          imageURL,
          height: 110,
        ),
      ],
    );
  }
}
