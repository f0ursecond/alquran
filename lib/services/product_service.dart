import 'dart:convert';

import 'package:crud/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body) as List;
        final product = json.map((e) {
          return Product(
              id: e['id'],
              userId: e['userId'],
              title: e['title'],
              completed: e['completed']);
        }).toList();
        return product;
      } else {
        throw (response.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }
}

// if (response.statusCode == 200) {
      
//     }