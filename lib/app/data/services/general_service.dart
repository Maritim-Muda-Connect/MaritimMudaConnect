import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class GeneralService {
  Future<GeneralResponse> fetchGeneral() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/profile/general"),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      var data = generalResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load general');
    }
  }

  Future<bool> updateGeneral(
    GeneralRequest requests,
    File imagePhoto,
    File imageIdentity,
  ) async {
    String? token = await UserPreferences().getToken();

    final url = Uri.parse("$baseUrl/profile/general");
    var request = http.MultipartRequest("POST", url);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['name'] = requests.name;
    request.fields['linkedin_profile'] = requests.linkedinProfile;
    request.fields['instagram_profile'] = requests.instagramProfile;
    request.fields['gender'] = requests.gender.toString();
    request.fields['place_of_birth'] = requests.placeOfBirth;
    request.fields['date_of_birth'] = requests.dateOfBirth;
    request.fields['first_expertise_id'] = requests.firstExpertiseId.toString();
    request.fields['second_expertise_id'] =
        requests.secondExpertiseId.toString();
    request.fields['permanent_address'] = requests.permanentAddress;
    request.fields['residence_address'] = requests.residenceAddress;
    request.fields['bio'] = requests.bio;

    if (imagePhoto.path.isNotEmpty) {
      var photo = await http.MultipartFile.fromPath(
        "photo",
        imagePhoto!.path,
        filename: imagePhoto.path.split('/').last,
      );
      request.files.add(photo);
    }
    if (imageIdentity.path.isNotEmpty) {
      var identity = await http.MultipartFile.fromPath(
        "identity_card",
        imageIdentity!.path,
        filename: imageIdentity.path.split('/').last,
      );
      request.files.add(identity);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
