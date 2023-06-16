import 'package:flutter/material.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';

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
    'zipcode': '',
    'city': '',
    'countryId': null,
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

  void _saveItemStep2() {
    if (_formKey2.currentState!.validate()) {
      _formKey2.currentState!.save();
      setState(() {
        _registerStage = 2;
      });
    }
  }

  void _saveItemStep3() {
    if (_formKey3.currentState!.validate()) {
      _formKey3.currentState!.save();
      setState(() {
        _registerStage = 3;
      });

      ShopwareApiHelper().registerCustomer(
          salutationId: _salutationId,
          firstName: _firstName,
          lastName: _lastName,
          email: _enteredEmail,
          password: _enteredPassword,
          billingAddress: _billingAdress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: FutureBuilder(
        future: ShopwareApiHelper().getRegistrationInfo(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text('Something went wrong, please restart the App'),
            );
          } else if (snapshot.data!['salutations'] == null ||
              snapshot.data!['countries'] == null) {
            return const Center(
              child: Text(
                  'We could Get all information from our Servers. Please restart the App.'),
            );
          }

          _salutationId ??= snapshot.data!['salutations'][0]['id'];
          _billingAdress['countryId'] ??= snapshot.data!['countries'][0]['id'];

          return IndexedStack(
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
                    DropdownButtonFormField(
                      value: _salutationId,
                      items: snapshot.data!['salutations']
                          .map<DropdownMenuItem<Object>>(
                            (ele) => DropdownMenuItem(
                              value: ele['id'],
                              child: Text(
                                ele['displayName'],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _salutationId = value;
                        });
                      },
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
                      textCapitalization: TextCapitalization.words,
                      autocorrect: false,
                      obscureText: false,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Name';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _firstName = newValue!,
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
                      textCapitalization: TextCapitalization.words,
                      autocorrect: false,
                      obscureText: false,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Name';
                        }

                        return null;
                      },
                      onSaved: (newValue) => _lastName = newValue!,
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
                          onPressed: () => _saveItemStep2(),
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
                    DropdownButtonFormField(
                      value: _billingAdress['countryId']!,
                      items: snapshot.data!['countries']!
                          .map<DropdownMenuItem<String>>(
                            (ele) => DropdownMenuItem<String>(
                              value: ele['id'],
                              child: Text(
                                ele['name'],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _billingAdress['countryId'] = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        label: const Text('Street'),
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
                        if (value == null || value.isEmpty) {
                          return 'Pleas provide a valid Street name';
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          _billingAdress['street'] = newValue!,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        label: const Text('Zip-code'),
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
                      obscureText: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Password (At least 8 characters) ';
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          _billingAdress['zipcode'] = newValue!,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        label: const Text('City'),
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
                      obscureText: false,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid City';
                        }

                        return null;
                      },
                      onSaved: (newValue) => _billingAdress['city'] = newValue!,
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
                          onPressed: () => _saveItemStep3(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 244, 130, 70),
                              width: 2,
                            ),
                            foregroundColor:
                                const Color.fromARGB(255, 244, 130, 70),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text('You will be logged in shortly'),
              )
            ],
          );
        },
      ),
    );
  }
}
