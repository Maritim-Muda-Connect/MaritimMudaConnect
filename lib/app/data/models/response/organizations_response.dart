// To parse this JSON data, do
//
//     final organizationsResponse = organizationsResponseFromJson(jsonString);

import 'dart:convert';

List<OrganizationsResponse> organizationsResponseFromJson(String str) =>
    List<OrganizationsResponse>.from(
        json.decode(str).map((x) => OrganizationsResponse.fromJson(x)));

String organizationsResponseToJson(List<OrganizationsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrganizationsResponse {
  int? id;
  String? uuid;
  int? userId;
  String? organizationName;
  String? role;
  DateTime? periodStartDate;
  DateTime? periodEndDate;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrganizationsResponse({
    this.id,
    this.uuid,
    this.userId,
    this.organizationName,
    this.role,
    this.periodStartDate,
    this.periodEndDate,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
  });

  factory OrganizationsResponse.fromJson(Map<String, dynamic> json) =>
      OrganizationsResponse(
        id: json["id"],
        uuid: json["uuid"],
        userId: json["user_id"],
        organizationName: json["organization_name"],
        role: json["role"],
        periodStartDate: json["period_start_date"] == null
            ? null
            : DateTime.parse(json["period_start_date"]),
        periodEndDate: json["period_end_date"] == null
            ? null
            : DateTime.parse(json["period_end_date"]),
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
        "organization_name": organizationName,
        "role": role,
        "period_start_date": periodStartDate?.toIso8601String(),
        "period_end_date": periodEndDate?.toIso8601String(),
        "order_column": orderColumn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
