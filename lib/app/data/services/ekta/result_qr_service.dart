import 'package:maritimmuda_connect/app/data/models/response/result_qr_response.dart';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/services/config.dart';

class ResultQrService {
  Future<ResultQrResponse> fetchMemberQr(String uid) async {
    final response = await http.get(
      Uri.parse("$baseUrl/user/$uid/membership-status"),
      headers: headersNoToken,
    );

    if (response.statusCode == 200) {
      var data = resultQrResponseFromJson(response.body);
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
