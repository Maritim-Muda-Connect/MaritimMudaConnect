import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('token');
  }

  Future<String?> getUserId() async {
    final prefs = await _getPrefs();
    return prefs.getString('userId');
  }

  Future<String?> getUid() async {
    final prefs = await _getPrefs();
    return prefs.getString('uid');
  }

  Future<String?> getUuid() async {
    final prefs = await _getPrefs();
    return prefs.getString('uuid');
  }

  Future<String?> getName() async {
    final prefs = await _getPrefs();
    return prefs.getString('name');
  }

  Future<String?> getEmail() async {
    final prefs = await _getPrefs();
    return prefs.getString('email');
  }

  Future<int?> getSerialNumber() async {
    final prefs = await _getPrefs();
    return prefs.getInt('serial_number');
  }
  
  Future<String?> getPlaceOfBirth() async {
    final prefs = await _getPrefs();
    return prefs.getString('place_of_birth');
  }

  Future<String?> getBio() async {
    final prefs = await _getPrefs();
    return prefs.getString('bio');
  }

  Future<String?> getCreatedAt() async {
    final prefs = await _getPrefs();
    return prefs.getString('created_at');
  }

  Future<void> logout() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }
}
