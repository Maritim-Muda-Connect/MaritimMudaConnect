


import 'package:maritimmuda_connect/app/data/models/response/scholarship_response.dart';
import 'package:http/http.dart' as http;
import '../utils/user_preference.dart';
import 'config.dart';

class ScholarshipService {
  // Future<EventResponse> getAllEvents() async {
  Future<List<Scholarship>> getAllScholarship() async {
    String? token = await UserPreferences().getToken();
    print(token);
    final response = await http.get(Uri.parse("$baseUrl/scholarships"),
        headers: headerWithToken(token!));

    if (response.statusCode == 200) {
      var scholarshipData = scholarshipFromJson(response.body);
      print(scholarshipData);
      return scholarshipData;
    } else {
      throw Exception("Failed to load scholarships");
    }
  }
}
