import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/widgets/auth/login.dart';
import 'package:flutter_shopware_6_api/widgets/auth/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Image.asset(
          'assets/images/logo/Logo.png',
          width: 200,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Login' : 'Register',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            isLogin ? LoginForm() : RegisterForm(),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(isLogin ? 'Register' : 'Login'))
          ],
        ),
      ),
    );
  }
}
