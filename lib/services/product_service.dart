import 'dart:convert';

import 'package:crud/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';

    final response = await http.get(Uri.parse(url));

    final body = jsonDecode(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = body;
        List<Product> result = data.map((e) => Product.fromJson(e)).toList();

        return result;
      } else {
        throw (response.statusCode);
      }
    } catch (err) {
      throw Exception(
        err.toString(),
      );
    }
  }
}
