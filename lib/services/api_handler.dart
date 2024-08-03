import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/models/products_model.dart';

import '../consts/api_consts.dart';

class APIHandler {
  static Future<List<ProductModel>> getAllProducts() async {
    var uri = Uri.https(BASE_URL, "/api/v1/products");
    var response = await http.get(uri);

    var data = jsonDecode(response.body);
    List jsonProducts = [];
    for (var v in data) {
      jsonProducts.add(v);
    }

    return ProductModel.productsFromJSON(jsonProducts);
  }
}
