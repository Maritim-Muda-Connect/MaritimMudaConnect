import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/response/job_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class JobService {
  Future<List<JobResponse>> fetchJob() async {
    String? token = await UserPreferences().getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/job-posts'),
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = jobResponseFromJson(response.body);
      return data;
    } else {
       throw Exception('failed to get job');
    }
  }

}