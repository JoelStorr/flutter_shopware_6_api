import 'dart:convert';

import 'package:http/http.dart' as http;

final mainNavigatioUrl = Uri.https(
    'localhost', 'store-api/navigation/main-navigation/main-navigation');

final cateoryUrl = Uri.https('localhost', 'store-api/category');

Uri generateURL(String parameter) {
  return Uri.https('localhost', 'store-api/$parameter');
}

class ShopwareApiHelper {
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

    return [];
  }

  Future<Map<String, dynamic>> getCategories() async {
    final response = await http.post(cateoryUrl, headers: {
      'Content-Type': 'application/json',
      'sw-access-key': 'SWSCWVPZS3ROZHO1NEDVDEC3VA',
    });

    final Map<String, dynamic> categories = json.decode(response.body);

    return categories;
  }

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
      return [];
    }
    print(item['id']);

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
    print(productList);

    return elements;
  }

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
    print(productList);

    return elements;
  }
}
