import 'package:http/http.dart' as http;
import 'package:mechine_test_pinkolearn/domain/api_provider/api_provider.dart';

class Apirepository {
  final Apiprovider apiprovider = Apiprovider();

  Future<http.Response> fetchProduct() async {
    return apiprovider.products();
  }
}
