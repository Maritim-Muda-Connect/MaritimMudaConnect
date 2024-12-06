import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/researches_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/researches_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class ResearchesService {
  Future<List<ResearchesResponse>> fetchResearches() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/profile/researches'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      var data = researchesResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load researches');
    }
  }

  Future<bool> createResearche(ResearchesRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/researches'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateResearche(ResearchesRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/researches/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteResearche(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/researches/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
