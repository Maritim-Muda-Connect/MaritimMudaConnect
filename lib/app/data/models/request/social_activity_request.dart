import 'dart:convert';

String socialActivityRequestToJson(SocialActivityRequest data) => json.encode(data.toJson());

class SocialActivityRequest {
  String name;
  String role;
  String institutionName;
  String startDate;
  String endDate;

  SocialActivityRequest({
    required this.name,
    required this.role,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "role": role,
    "institution_name": institutionName,
    "start_date": startDate,
    "end_date": endDate,
  };
}