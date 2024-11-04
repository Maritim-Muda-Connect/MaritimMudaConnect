import 'dart:convert';

String workExperiencesRequestToJson(WorkExperiencesRequest data) => json.encode(data.toJson());

class WorkExperiencesRequest {
  String positionTitle;
  String companyName;
  String startDate;
  String endDate;

  WorkExperiencesRequest({
    required this.positionTitle,
    required this.companyName,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    "position_title": positionTitle,
    "company_name": companyName,
    "start_date": startDate,
    "end_date": endDate,
  };
}