import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mechine_test_pinkolearn/data/product model.dart';
import 'package:mechine_test_pinkolearn/domain/api_repository/api_repository.dart';

class ProductProvider extends ChangeNotifier {
  Products? products;
  bool isLoading = false;
  String error = '';
  final Apirepository apirepository = Apirepository();

  void fetchProducts() async {
    isLoading = true;
    error = "";
    notifyListeners();
    
    try {
      final Response response = await apirepository.fetchProduct();
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        products = Products.fromMap(data);
        print('Fetch success');
      } else if (response.statusCode == 404) {
        error = 'Products not found';
        print('Error: Products not found');
      } else {
        error = 'Failed to load products. Please try again later.';
        print('Error: ${response.statusCode}');
      }
    } on SocketException {
      error = 'No internet connection. Please check your network.';
      print('Error: No internet connection');
    } on FormatException {
      error = 'Bad response format. Failed to parse data.';
      print('Error: Bad response format');
    } catch (e) {
      error = 'An unexpected error occurred: $e';
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
