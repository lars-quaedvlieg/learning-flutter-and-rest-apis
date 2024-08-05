import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/models/categories_model.dart';
import 'package:store_api_flutter_course/models/products_model.dart';
import 'package:store_api_flutter_course/models/user_model.dart';

import '../consts/api_consts.dart';

class APIHandler {
  static Future<List<dynamic>> getData({
    required String target,
    String? limit,
  }) async {
    try {
      var uri = Uri.https(BASE_URL, "/api/v1/$target",
          target == "products" ? {"offset": "0", "limit": limit} : {});
      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw data["message"];
      }

      List tmpData = [];
      for (var v in data) {
        tmpData.add(v);
      }

      return tmpData;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<List<ProductModel>> getAllProducts({required String limit}) async {
    List tmp = await getData(target: "products", limit: limit);
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

  static Future<ProductModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, "/api/v1/products/$id");
      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw data["message"];
      }

      return ProductModel.fromJson(data);
    } catch (error) {
      log("An error occurred while getting product info $error");
      throw error.toString();
    }
  }
}
