import "dart:convert";
import "package:http/http.dart" as http;
import "package:maritimmuda_connect/app/data/models/request/login_request.dart";
import "package:maritimmuda_connect/app/data/models/request/register_request.dart";
import "package:maritimmuda_connect/app/data/models/response/login_response.dart";
import "package:maritimmuda_connect/app/data/services/config.dart";
import "package:shared_preferences/shared_preferences.dart";

class AuthService {
  Future<int> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: headersNoToken,
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = loginResponseFromJson(response.body).token!;
      int userId = loginResponseFromJson(response.body).user!.id!;
      String? uid = loginResponseFromJson(response.body).user?.uid ?? "";
      String uuid = loginResponseFromJson(response.body).user!.uuid!;
      String name = loginResponseFromJson(response.body).user!.name!;
      String email = loginResponseFromJson(response.body).user!.email!;
      String placeOfBirth = loginResponseFromJson(response.body).user!.placeOfBirth!;
      String bio = loginResponseFromJson(response.body).user!.bio ?? "No bio yet";
      DateTime emailVerifiedAt = loginResponseFromJson(response.body).user!.emailVerifiedAt!;
      int serialNumber =
          loginResponseFromJson(response.body).user?.serialNumber ?? 0;

      await prefs.setString("token", token);
      await prefs.setString("userId", userId.toString());
      await prefs.setString("uid", uid);
      await prefs.setString("uuid", uuid);
      await prefs.setString("name", name);
      await prefs.setInt("serial_number", serialNumber);
      await prefs.setString("email", email);
      await prefs.setString("place_of_birth", placeOfBirth);
      await prefs.setString("bio", bio);
      await prefs.setString("created_at", emailVerifiedAt.toIso8601String());

      return 200;
    } else {
      return response.statusCode;
    }
  }

  Future<bool> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: headersNoToken,
      body: jsonEncode(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/forgot-password"),
      headers: headersNoToken,
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      print("Berhasil ${response.body}");
      return true;
    } else {
      print("Gagal ${response.body}");
      return false;
    }
  }
}
