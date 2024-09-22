import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mechine_test_pinkolearn/data/product%20model.dart';

class Apiprovider {
  Future<http.Response> products() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
