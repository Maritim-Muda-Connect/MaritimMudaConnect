import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/educations_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/educations_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class EducationsService{
  Future<List<EducationsResponse>> fetchEducations() async{
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/profile/educations'),
      headers: headerWithToken(token!),
    );

    if(response.statusCode == 200){
      var data = educationsResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load Educations');
    }
  }

  Future<bool> createEducations(EducationsRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/educations'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEducations(EducationsRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/educations/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteEducations(int id) async{
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/educations/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200){
      return true;
    } else{
      return false;
    }
  }
}