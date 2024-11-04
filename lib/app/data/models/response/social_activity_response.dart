import 'dart:convert';

List<SocialActivityResponse> socialactivityResponseFromJson(String str) =>
    List<SocialActivityResponse>.from(
        json.decode(str).map((x) => SocialActivityResponse.fromJson(x)));

String socialactivityResponseToJson(List<SocialActivityResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialActivityResponse {
  int? id;
  String? uuid;
  int? userId;
  String? name;
  String? role;
  String? institutionName;
  DateTime? startDate;
  DateTime? endDate;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;

  SocialActivityResponse({
    this.id,
    this.uuid,
    this.userId,
    this.name,
    this.role,
    this.institutionName,
    this.startDate,
    this.endDate,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialActivityResponse.fromJson(Map<String, dynamic> json) =>
      SocialActivityResponse(
        id: json["id"],
        uuid: json["uuid"],
        userId: json["user_id"],
        name: json["name"],
        role: json["role"],
        institutionName: json["institution_name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        orderColumn: json["order_column"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "user_id": userId,
        "name": name,
        "role": role,
        "institution_name": institutionName,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "order_column": orderColumn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
