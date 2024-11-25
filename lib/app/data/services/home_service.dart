import 'package:maritimmuda_connect/app/data/models/response/member_response.dart';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class HomeService {
  Future<MemberResponse> getAllMembers() async {
    String? token = await UserPreferences().getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/find-member"),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      var data = memberResponseFromJson(response.body);
      return data;
    } else {
      return throw ("Error disindah");
    }
  }
}
