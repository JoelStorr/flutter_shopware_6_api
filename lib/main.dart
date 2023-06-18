import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/auth_screen.dart';
import 'dart:io';

import 'package:flutter_shopware_6_api/screens/tab_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? isLoggedIn = 'demo';

  void changeLogIn(String context) {
    setState(() {
      isLoggedIn = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My App',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: isLoggedIn == null
            ? AuthScreen(
                changeLogin: changeLogIn,
              )
            : TabScreen());
  }
}
