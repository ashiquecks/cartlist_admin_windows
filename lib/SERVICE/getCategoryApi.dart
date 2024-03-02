import 'dart:convert';
import 'package:cartlist_admin/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist_admin/MODAL/categoryModal.dart';
import 'package:http/http.dart';

class Categoryservice {
  static Future<NetworkResponse<List<CategoryModal>>> getCategoryResponse(
      {int limit = 20, int page = 1}) async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getcategorydetails.php'));

      print(response.body);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<CategoryModal> categoryList = [];
        body.forEach((e) {
          CategoryModal categoryResponse = CategoryModal.fromJson(e);
          categoryList.add(categoryResponse);
        });
        return NetworkResponse(true, categoryList,
            responseCode: response.statusCode);
      } else {
        print("somthing else");
      }
    } catch (e) {
      print(e.toString());
    }
    throw Exception('Unexpected error occured!');
  }
}
