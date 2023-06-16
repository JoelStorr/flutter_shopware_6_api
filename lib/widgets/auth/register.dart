import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var _enteredEmail;
  var _enteredPassword;
  var _confirmPassword;

  final _formKey = GlobalKey<FormState>();

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value) => _enteredPassword = value,
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
            TextFormField(
              maxLength: 100,
              decoration: InputDecoration(
                label: const Text('Confirm Password'),
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
                if (value != _enteredPassword) {
                  return 'Both Passwords have to match';
                }
                return null;
              },
              onSaved: (newValue) => _confirmPassword = newValue!,
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
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
