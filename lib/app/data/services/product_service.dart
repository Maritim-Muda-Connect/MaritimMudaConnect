import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class ProductService {
  Future<ProductResponse> fetchProducts() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/store"),
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = productResponseFromJson(response.body);
      print("berhasil $data");
      return data;
    } else {
      print("Gagal $response.body");
      throw Exception('Failed to load products');
    }
  }
}
