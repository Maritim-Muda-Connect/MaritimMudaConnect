
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/social_activity_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/social_activity_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class SocialActivityService{
  Future<List<SocialActivityResponse>> fetchSocialActivity() async{
    String? token = await UserPreferences().getToken();
    
    final response = await http.get(
      Uri.parse('$baseUrl/profile/social-activities'),
      headers: headerWithToken(token!),
    );

    if(response.statusCode == 200){
      var data = socialactivityResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load Social Activity');
    }
  }

  Future<bool> createSocialActivity(SocialActivityRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/social-activities'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateSocialActivity(SocialActivityRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/social-activities/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteSocialActivity(int id) async{
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/social-activities/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200){
      return true;
    } else{
      return false;
    }
  }
}