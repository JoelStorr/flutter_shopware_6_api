import 'dart:convert';
import 'package:http/http.dart' as http;

final mainNavigatioUrl = Uri.https(
    'localhost', 'store-api/navigation/main-navigation/main-navigation');

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

      print(categories);
      return categories;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
