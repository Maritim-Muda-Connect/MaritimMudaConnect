import 'dart:convert';

List<WorkExperiencesResponse> workExperiencesResponseFromJson(String str) => List<WorkExperiencesResponse>.from(json.decode(str).map((x) => WorkExperiencesResponse.fromJson(x)));

String workExperiencesResponseToJson(List<WorkExperiencesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkExperiencesResponse {
  int? id;
  String? uuid;
  int? userId;
  String? positionTitle;
  String? companyName;
  DateTime? startDate;
  DateTime? endDate;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;

  WorkExperiencesResponse({
    this.id,
    this.uuid,
    this.userId,
    this.positionTitle,
    this.companyName,
    this.startDate,
    this.endDate,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkExperiencesResponse.fromJson(Map<String, dynamic> json) => WorkExperiencesResponse(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    positionTitle: json["position_title"],
    companyName: json["company_name"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    orderColumn: json["order_column"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "position_title": positionTitle,
    "company_name": companyName,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "order_column": orderColumn,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}