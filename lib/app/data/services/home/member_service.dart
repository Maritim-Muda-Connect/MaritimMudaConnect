import 'package:maritimmuda_connect/app/data/models/response/member_response.dart';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/response/uid_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class MemberService {
  Future<MemberResponse> getAllMembers() async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse("$baseUrl/find-member"),
        headers: headerWithToken(token!),
      );

      if (response.statusCode == 200) {
        var data = memberResponseFromJson(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to fetch members: ${response.statusCode} - ${response.body}');
        // return MemberResponse();
        //comment throw exception and return MemberResponse() to avoid crash if api is down
      }
    } catch (e) {
      rethrow;
      // return MemberResponse();
      //comment rethrow and return MemberResponse() to avoid crash if api is down
    }
  }

  Future<UidResponse> getEmail(String email) async {
    final response =
        await http.get(Uri.parse("$baseUrl/user/$email/check-uid"));

    if (response.statusCode == 200) {
      var data = uidResponseFromJson(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to fetch email: ${response.statusCode} - ${response.body}');
    }
  }
}
