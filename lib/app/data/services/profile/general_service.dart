import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/delete_account_request.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/delete_account_response.dart';
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

  Future<DeleteAccountResponse> deleteAccountRequest(
      DeleteAccountRequest request) async {
    String? token = await UserPreferences().getToken();

    final url = Uri.parse("$baseUrl/user/delete-request");
    log("Sending delete account request to: $url");
    log("Delete account request body: ${jsonEncode(request.toJson())}");

    final response = await http.post(
      url,
      headers: headerWithToken(token!),
      body: jsonEncode(request.toJson()),
    );

    log("Delete account response status: ${response.statusCode}");
    log("Delete account response body: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return deleteAccountResponseFromJson(response.body);
      } catch (e) {
        return DeleteAccountResponse(success: true, message: "Request processed");
      }
    } else {
      if (response.statusCode == 429) {
        return DeleteAccountResponse(
          success: false,
          message: 'Too Many Attempts. Please try again later.',
        );
      } else if (response.statusCode >= 500) {
        return DeleteAccountResponse(
          success: false,
          message: 'Server error. Please try again later.',
        );
      }

      try {
        final data = jsonDecode(response.body);
        return DeleteAccountResponse(
          success: false,
          message: data['message'] ?? 'An error occurred',
        );
      } catch (e) {
        return DeleteAccountResponse(
          success: false,
          message: 'An error occurred',
        );
      }
    }
  }

  Future<bool> updateGeneral(
    GeneralRequest requests,
    File imagePhoto,
    File imageIdentity,
    File imagePayment,
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
    request.fields['citizenship'] = requests.citizenship;

    if (imagePhoto.path.isNotEmpty) {
      var photo = await http.MultipartFile.fromPath(
        "photo",
        imagePhoto.path,
        filename: imagePhoto.path.split('/').last,
      );
      request.files.add(photo);
    }
    if (imageIdentity.path.isNotEmpty) {
      var identity = await http.MultipartFile.fromPath(
        "identity_card",
        imageIdentity.path,
        filename: imageIdentity.path.split('/').last,
      );
      request.files.add(identity);
    }
    if (imagePayment.path.isNotEmpty) {
      var payment = await http.MultipartFile.fromPath(
        "payment_confirm",
        imagePayment.path,
        filename: imagePayment.path.split('/').last,
      );
      request.files.add(payment);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> notifyMemberCard() async {
    String? token = await UserPreferences().getToken();

    final url = Uri.parse("$baseUrl/profile/notify-member-card");
    log("Sending notify member card request to: $url");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    log("Notify member card response status: ${response.statusCode}");
    log("Notify member card response body: ${response.body}");

    if (response.statusCode == 200) {
      return null;
    } else {
      try {
        final data = jsonDecode(response.body);
        if (data['message'] != null) {
          return data['message'];
        }
      } catch (e) {
        // ignore json decode error
      }
      return "Failed to send email";
    }
  }
}
