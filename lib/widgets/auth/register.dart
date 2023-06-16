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

  var _salutationId;
  var _firstName;
  var _lastName;
  var _storefrontURL;
  final _billingAdress = {
    'street': '',
    'zip-code': '',
    'city': '',
    'countryId': '',
  };

  int _registerStage = 0;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  void _saveItemStep1() {
    if (_formKey1.currentState!.validate()) {
      _formKey1.currentState!.save();
      setState(() {
        _registerStage = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(25),
        child: IndexedStack(
          index: _registerStage,
          children: [
            /* NOTE: Get Email & Password */
            Form(
              key: _formKey1,
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
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Step ${_registerStage + 1} of 3'),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        onPressed: () => _saveItemStep1(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2,
                          ),
                          foregroundColor:
                              const Color.fromARGB(255, 244, 130, 70),
                        ),
                        child: const Text(
                          'Next Step',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /* NOTE: Get Name Info and Gender */
            Form(
              key: _formKey2,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 100,
                    decoration: InputDecoration(
                      label: const Text('Gender'),
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
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      label: const Text('First Name'),
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      label: const Text('Last Name'),
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Step ${_registerStage + 1} of 3'),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        /* TODO: Chnage Validation Function */
                        onPressed: () => _saveItemStep1(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2,
                          ),
                          foregroundColor:
                              const Color.fromARGB(255, 244, 130, 70),
                        ),
                        child: const Text(
                          'Next Step',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /* NOTE: Adress and Shipping Info */
            Form(
              key: _formKey3,
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
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 244, 130, 70)),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Step ${_registerStage + 1} of 3'),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        /* TODO: Chnage Validation Function */
                        onPressed: () => _saveItemStep1(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 244, 130, 70),
                            width: 2,
                          ),
                          foregroundColor:
                              const Color.fromARGB(255, 244, 130, 70),
                        ),
                        child: const Text(
                          'Next Step',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
