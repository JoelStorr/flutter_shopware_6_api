import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopware_6_api/helpers/api_helpers.dart';
import 'package:flutter_shopware_6_api/store/auth_provider.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({
    super.key,
    /* required this.changeLogin */
  });

  /* Function changeLogin; */

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  String? _enteredEmail;
  String? _enteredPassword;
  String? _confirmPassword;

  String? _salutationId;
  String? _firstName;
  String? _lastName;
  String? _storefrontURL;
  final _billingAdress = {
    'street': '',
    'zipcode': '',
    'city': '',
    'countryId': null,
  };

/* NOTE: Handle Registration Steps */
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

  @override
  Widget build(BuildContext context) {
    /* final _setLogin = ref.read(authProvider.notifier).setAuth; */

    void saveItemStep3() async {
      if (_formKey3.currentState!.validate()) {
        _formKey3.currentState!.save();
        setState(() {
          _registerStage = 3;
        });

        final contextKey = await ShopwareApiHelper().registerCustomer(
          salutationId: _salutationId!,
          firstName: _firstName!,
          lastName: _lastName!,
          email: _enteredEmail!,
          password: _enteredPassword!,
          billingAddress: _billingAdress,
        );

        await ShopwareApiHelper().createCart(contextToken: contextKey!);

        /* widget.changeLogin(contextKey); */
        ref.watch(authProvider.notifier).setAuth(contextKey);
      }
    }

    return Container(
      padding: const EdgeInsets.all(25),
      child: FutureBuilder(
        future: ShopwareApiHelper().getRegistrationInfo(),
        builder: (context, snapshot) {
          /* NOTE: Loading and Exceptions */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 241, 105, 33)));
          } else if (snapshot.data == null) {
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
                          .map<DropdownMenuItem<String>>(
                            (ele) => DropdownMenuItem<String>(
                              value: ele['id']!,
                              child: Text(
                                ele['displayName']!,
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
                          onPressed: () => saveItemStep3(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('You will be logged in shortly'),
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 241, 105, 33),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
