import 'package:flutter/material.dart';

class MainPillButton extends StatelessWidget {
  MainPillButton({
    super.key,
    this.activeElement = 'left',
    required this.textLeft,
    required this.textRight,
  });
  String activeElement;
  String textLeft;
  String textRight;

  @override
  Widget build(BuildContext context) {
    return activeElement == 'right'
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0)
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        child: Text(
                          textLeft,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 244, 130, 70)),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20));
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.transparent;
                            }
                            return const Color.fromARGB(255, 244, 130, 70);
                          }),
                        ),
                        child: Text(
                          textRight,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0)
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20));
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.transparent;
                            }
                            return const Color.fromARGB(255, 244, 130, 70);
                          }),
                        ),
                        child: Text(
                          textLeft,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        child: Text(
                          textRight,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 244, 130, 70)),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
