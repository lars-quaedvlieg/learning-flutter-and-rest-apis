import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/models/categories_model.dart';
import 'package:store_api_flutter_course/models/products_model.dart';
import 'package:store_api_flutter_course/models/user_model.dart';

import '../consts/api_consts.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    var uri = Uri.https(BASE_URL, "/api/v1/$target");
    var response = await http.get(uri);

    var data = jsonDecode(response.body);
    List tmpData = [];
    for (var v in data) {
      tmpData.add(v);
    }

    return tmpData;
  }

  static Future<List<ProductModel>> getAllProducts() async {
    List tmp = await getData(target: "products");
    return ProductModel.productsFromJSON(tmp);
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    List tmp = await getData(target: "categories");
    return CategoryModel.categoriesFromJSON(tmp);
  }

  static Future<List<UserModel>> getAllUsers() async {
    List tmp = await getData(target: "users");
    return UserModel.usersFromJSON(tmp);
  }
}
