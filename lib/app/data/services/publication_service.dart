import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/publication_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/publication_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class PublicationService {
  Future<List<PublicationResponse>> fetchPublication() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/profile/publications"),
      headers: headerWithToken(token!),
    );
    if (response.statusCode == 200) {
      var data = publicationResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to Publication data');
    }
  }

  Future<bool> createPublication(PublicationRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/publications'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePublications(PublicationRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/publications/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePublication(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/publications/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}