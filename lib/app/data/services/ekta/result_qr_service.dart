import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
import 'package:maritimmuda_connect/app/data/models/response/result_qr_response.dart';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

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

  Future<GeneralResponse> fetchEkta() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/profile/general"),
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = generalResponseFromJson(response.body);
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
