import 'dart:convert';
import 'package:http/http.dart' as http;

final url = Uri.https('localhost', 'store-api/category');

class ShopwareApiHelper {
  Future<List> getCategoreis() async {
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'sw-access-key': 'SWSCA0LLWTNISMHPVUZXRFVNNW',
        },
      );

      final Map<String, dynamic> categories = json.decode(response.body);

      print(categories['elements'][0]['name']);
      return categories['elements'];
    } catch (e) {
      print(e);
    }

    return [];
  }
}
