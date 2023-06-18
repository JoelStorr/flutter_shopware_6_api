import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/screens/auth_screen.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_shopware_6_api/screens/tab_screen.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';

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
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String isLoggedIn = ref.watch(authProvider);

    return MaterialApp(
        title: 'My App',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: isLoggedIn.isEmpty ? AuthScreen() : const TabScreen());
  }
}
