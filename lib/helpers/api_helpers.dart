import 'dart:convert';

import 'package:http/http.dart' as http;

final mainNavigatioUrl = Uri.https(
    'localhost', 'store-api/navigation/main-navigation/main-navigation');

final cateoryUrl = Uri.https('localhost', 'store-api/category');

Uri generateURL(String parameter) {
  return Uri.https('localhost', 'store-api/$parameter');
}

class ShopwareApiHelper {
  /* NOTE: Main App Navigation */

  Future<List<dynamic>> getMainNavigation() async {
    try {
      final response = await http.post(
        mainNavigatioUrl,
        headers: {
          'Content-Type': 'application/json',
          'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        },
      );

      final List<dynamic> categories = json.decode(response.body);

      return categories;
    } catch (e) {
      throw Exception();
    }
  }

/* NOTE: Get Categories */
  Future<Map<String, dynamic>> getCategories() async {
    final response = await http.post(cateoryUrl, headers: {
      'Content-Type': 'application/json',
      'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
    });

    final Map<String, dynamic> categories = json.decode(response.body);

    return categories;
  }

/* NOTE: Get Products for Category */
  Future<List<Map<dynamic, dynamic>>>? getProductsForCategory(
      String categoryName) async {
    final categoryResponse = await getCategories();
    final List categoryList = categoryResponse['elements'];

    Map? item;

    for (final val in categoryList) {
      bool isCategory = false;
      for (final item in val['breadcrumb']) {
        if (item == categoryName) {
          isCategory = true;
          break;
        }
      }

      if (isCategory) {
        item = val;
        break;
      }
    }

    if (item == null) {
      throw Exception();
    }

    final response =
        await http.post(generateURL('product-listing/${item['id']}'),
            headers: {
              'Content-Type': 'application/json',
              'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
            },
            body: jsonEncode({
              'associations': {
                'properties': ['Colours'],
              }
            }));

    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Map<String, dynamic>> elements;

    elements = List<Map<String, dynamic>>.from(productList['elements']);

    return elements;
  }

  /* NOTE: Get Product for a given Category */
  Future<List<Map<dynamic, dynamic>>>? getProductsForCategoryID(
      String categoryId) async {
    final response = await http.post(generateURL('product-listing/$categoryId'),
        headers: {
          'Content-Type': 'application/json',
          'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        },
        body: jsonEncode({
          'associations': {
            'properties': ['Colours'],
          }
        }));

    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Map<String, dynamic>> elements;

    elements = List<Map<String, dynamic>>.from(productList['elements']);

    return elements;
  }

/* NOTE: Search for Product */
  Future<List<Map<dynamic, dynamic>>>? getSearchProducts(
      String searchTerm) async {
    final response = await http.post(generateURL('search'),
        headers: {
          'Content-Type': 'application/json',
          'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        },
        body: jsonEncode({
          "search": searchTerm,
          'associations': {
            'properties': ['Colours'],
          }
        }));

    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Map<String, dynamic>> elements;

    elements = List<Map<String, dynamic>>.from(productList['elements']);

    return elements;
  }

  /* NOTE: Salutation Informations */

  Future<List<Map<dynamic, dynamic>>>? getSalutationIds() async {
    final response = await http.post(
      generateURL('salutation'),
      headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
      },
    );

    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Map<String, dynamic>> elements;

    elements = List<Map<String, dynamic>>.from(productList['elements']);

    return elements;
  }

  /* NOTE: Accaptable Countries */
  Future<List<Map<dynamic, dynamic>>>? getCountries() async {
    final response = await http.post(
      generateURL('country'),
      headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
      },
    );

    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Map<String, dynamic>> elements;

    elements = List<Map<String, dynamic>>.from(productList['elements']);

    return elements;
  }

  /* NOTE: Retrive Context Token */
  Future<String> getContext() async {
    final response = await http.get(
      generateURL('context'),
      headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
      },
    );

    final Map<String, dynamic> context = json.decode(response.body);
    return context['token'];
  }

  /* NOTE: Fetches needed informations for Registration */
  Future<Map>? getRegistrationInfo() async {
    final salutationResponse = await getSalutationIds();
    final countryResponse = await getCountries();

    return {
      'salutations': salutationResponse,
      'countries': countryResponse,
    };
  }

  /* NOTE: Register a new Customer */
  Future<String?> registerCustomer({
    required String salutationId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required Map billingAddress,
  }) async {
    final contextToken = await getContext();

    final response = await http.post(
      generateURL('account/register'),
      headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        'sw-context-token': contextToken,
      },
      body: jsonEncode(
        {
          "salutationId": salutationId,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "storefrontUrl": "http://localhost/app",
          "billingAddress": billingAddress
        },
      ),
    );

    final Map<String, String> contextValue = response.headers;
    return contextValue['sw-context-token'];
  }

  /* NOTE: Login existing Customer */
  Future<String?> loginCustomer({
    required String email,
    required String password,
  }) async {
    final contextToken = await getContext();

    final response = await http.post(
      generateURL('account/login'),
      headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        'sw-context-token': contextToken,
      },
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    final Map<String, dynamic> contextValue = json.decode(response.body);
    return contextValue['contextToken'];
  }

/* NOTE: Check Customer Data */
  Future<Map<dynamic, dynamic>>? checkCustomer(
      {required String contextToken}) async {
    try {
      final response = await http.post(
        generateURL('account/list-address'),
        headers: {
          'Content-Type': 'application/json',
          'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
          'sw-context-token': contextToken,
        },
      );

      final Map<String, dynamic> customerData = json.decode(response.body);
      final Map<String, dynamic> elements;

      elements = Map<String, dynamic>.from(customerData['elements'][0]);

      return elements;
    } catch (e) {
      throw Error();
    }
  }

  /* NOTE: Get Specific Product */
  Future<Map<dynamic, dynamic>>? getProduct({required String productID}) async {
    try {
      final response =
          await http.post(generateURL('product/$productID'), headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
      });
      /* body: jsonEncode({'options': []})); */

      final Map<String, dynamic> customerData = json.decode(response.body);
      final Map<String, dynamic> elements;

      elements = Map<String, dynamic>.from(customerData['product']);

      return elements;
    } catch (e) {
      throw Error();
    }
  }

/* NOTE: Create a Cart */
  Future<Map<dynamic, dynamic>>? createCart(
      {required String contextToken}) async {
    try {
      final response = await http.post(generateURL('checkout/cart'), headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        'sw-context-token': contextToken,
      });
      /* body: jsonEncode({'options': []})); */

      final Map<String, dynamic> cartInfo = json.decode(response.body);
      final Map<String, dynamic> cart;

      cart = Map<String, dynamic>.from(cartInfo);

      return cart;
    } catch (e) {
      throw Error();
    }
  }

  /* NOTE: Add item / items to Cart */
  Future<Map<dynamic, dynamic>>? addToCart(
      {required String contextToken}) async {
    try {
      final response =
          await http.post(generateURL('checkout/cart/line-item'), headers: {
        'Content-Type': 'application/json',
        'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
        'sw-context-token': contextToken,
      });
      /* body: jsonEncode({'options': []})); */

      final Map<String, dynamic> customerData = json.decode(response.body);
      final Map<String, dynamic> elements;

      elements = Map<String, dynamic>.from(customerData['product']);

      return elements;
    } catch (e) {
      throw Error();
    }
  }
}
