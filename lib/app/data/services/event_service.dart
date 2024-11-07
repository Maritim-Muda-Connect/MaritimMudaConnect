import 'package:maritimmuda_connect/app/data/models/response/event_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:http/http.dart' as http;

class EventService {

  Future<List<Event>> getAllEvents() async {
    String? token = await UserPreferences().getToken();
    print(token);
    final response = await http.get(Uri.parse("$baseUrl/events"),
        headers: headerWithToken(token!));

    if (response.statusCode == 200) {
      var eventData = eventResponseFromJson(response.body);
      print(eventData);
      return eventData;
    } else {
      throw Exception("Failed to load events");
    }
  }
}
