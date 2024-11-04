import 'dart:convert';

List<EducationsResponse> educationsResponseFromJson(String str) => List<EducationsResponse>.from(json.decode(str).map((x) => EducationsResponse.fromJson(x)));

String educationsResponseToJson(List<EducationsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EducationsResponse {
  int? id;
  String? uuid;
  int? userId;
  String? institutionName;
  String? major;
  int? level;
  DateTime? graduationDate;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;

  EducationsResponse({
    this.id,
    this.uuid,
    this.userId,
    this.institutionName,
    this.major,
    this.level,
    this.graduationDate,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
  });

  factory EducationsResponse.fromJson(Map<String, dynamic> json) => EducationsResponse(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    institutionName: json["institution_name"],
    major: json["major"],
    level: json["level"],
    graduationDate: json["graduation_date"] == null ? null : DateTime.parse(json["graduation_date"]),
    orderColumn: json["order_column"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "institution_name": institutionName,
    "major": major,
    "level": level,
    "graduation_date": graduationDate?.toIso8601String(),
    "order_column": orderColumn,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}