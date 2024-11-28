import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/response/analytic_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class AnalyticService {
  Future<AnalyticResponse> fetchAnalytics() async {
    String? token = await UserPreferences().getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),  // Replace with your actual API endpoint for analytics
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = analyticResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load analytics');
    }
  }
}
