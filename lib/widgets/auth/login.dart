import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  LoginForm({
    super.key,
    /* required this.changeLogin */
  });

  /* Function changeLogin; */
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  var _enteredEmail;
  var _enteredPassword;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _saveItem() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final contexToken = await ShopwareApiHelper()
            .loginCustomer(email: _enteredEmail, password: _enteredPassword);

        //TODO: Change to global State
        /* widget.changeLogin(contexToken); */
        ref.watch(authProvider.notifier).setAuth(contexToken!);
      }
    }

    return Container(
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 100,
              decoration: InputDecoration(
                label: const Text('Email'),
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 244, 130, 70),
                ),
                counterText: "",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 244, 130, 70), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 100) {
                  return 'Please enter a valid Email adress ';
                }
                return null;
              },
              onSaved: (newValue) => _enteredEmail = newValue!,
            ),
            const SizedBox(
              height: 35,
            ),
            TextFormField(
              maxLength: 100,
              decoration: InputDecoration(
                label: const Text('Password'),
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelStyle:
                    const TextStyle(color: Color.fromARGB(255, 244, 130, 70)),
                counterText: "",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 244, 130, 70), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              obscureText: true,
              enableSuggestions: false,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length < 8 ||
                    value.trim().length > 100) {
                  return 'Please enter a valid Password (At least 8 characters) ';
                }
                return null;
              },
              onSaved: (newValue) => _enteredPassword = newValue!,
            ),
            const SizedBox(
              height: 35,
            ),
            OutlinedButton(
              onPressed: () => _saveItem(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color.fromARGB(255, 244, 130, 70),
                  width: 2,
                ),
                foregroundColor: const Color.fromARGB(255, 244, 130, 70),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
