import 'package:http/http.dart' as http;

class Apiprovider {
  Future<http.Response> products() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
