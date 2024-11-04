import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/models/request/organizations_request.dart';
import 'package:maritimmuda_connect/app/data/models/request/researches_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/researches_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/data/models/response/organizations_response.dart';

class OrganizationsService {
  Future<List<OrganizationsResponse>> fetchOrganizations() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/profile/organizations'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      var data = organizationsResponseFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load organizations');
    }
  }

  Future<bool> createOrganizations(OrganizationsRequest request) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/profile/organizations'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateOrganizations(OrganizationsRequest request, int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/profile/organizations/$id'),
      headers: headerWithToken(token!),
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteOrganizations(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/profile/organizations/$id'),
      headers: headerWithToken(token!),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
