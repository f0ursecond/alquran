import 'package:crud/model/product_model.dart';
import 'package:crud/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final _service = ProductService();
  bool isLoading = false;
  List<Product> _product = [];
  List<Product> get product => _product;

  Future<void> getAllProduct() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();
    _product = response;
    isLoading = false;
    notifyListeners();
  }
}
