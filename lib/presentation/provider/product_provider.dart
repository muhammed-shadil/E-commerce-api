import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:mechine_test_pinkolearn/data/product%20model.dart';
import 'package:mechine_test_pinkolearn/domain/api_repository/api_repository.dart';

class ProductProvider extends ChangeNotifier {
  Products? products;
  bool isLoading = false;
  String error = '';
  final Apirepository apirepository = Apirepository();

  
  void fetchproduts() async {
    isLoading = true;
    error = "";
    notifyListeners();
    try {
      final Response response = await apirepository.fetchProduct();
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        products = Products.fromMap(data);
        notifyListeners();
        print('success');
        print(products!.products[1].brand);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
