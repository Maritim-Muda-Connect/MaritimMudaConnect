import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/work_experiences_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/work_experiences_response.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';


class WorkExperiencesService {
  Future<List<WorkExperiencesResponse>> fetchWorkExperiences() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/profile/work-experiences'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      var data = workExperiencesResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load Work Experiences');
    }
  }

  Future<bool> createWorkExperience(WorkExperiencesRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/work-experiences'),
      headers: headerWithToken(token!),
      body: jsonEncode(request)
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateWorkExperience(WorkExperiencesRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/work-experiences/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteWorkExperiences(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/work-experiences/$id'),
      headers: headerWithToken(token!)
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}