import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/achievements_request.dart';
import 'package:maritimmuda_connect/app/data/models/request/publication_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/achievements_response.dart';
import 'package:maritimmuda_connect/app/data/models/response/publication_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievement/controllers/achievement_controller.dart';

class AchievementsService {
  Future<List<AchievementsResponse>> fetchAchievements() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/profile/achievements"),
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = achievementsResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to Achievements data');
    }
  }

  Future<bool> createAchievements(AchievementsRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/achievements'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAchievements(AchievementsRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/achievements/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAchievements(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/achievements/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}