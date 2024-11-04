import 'dart:convert';

String educationsRequestToJson(EducationsRequest data) => json.encode(data.toJson());

class EducationsRequest {
  String institutionName;
  String major;
  int level;
  String graduationDate;

  EducationsRequest({
    required this.institutionName,
    required this.major,
    required this.level,
    required this.graduationDate,
  });

  Map<String, dynamic> toJson() => {
    "institution_name": institutionName,
    "major": major,
    "level": level,
    "graduation_date": graduationDate,
  };
}