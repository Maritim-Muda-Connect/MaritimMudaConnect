// To parse this JSON data, do
//
//     final jobResponse = jobResponseFromJson(jsonString);

import 'dart:convert';

List<JobResponse> jobResponseFromJson(String str) => List<JobResponse>.from(json.decode(str).map((x) => JobResponse.fromJson(x)));

String jobResponseToJson(List<JobResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobResponse {
  int? id;
  String? uuid;
  String? positionTitle;
  String? companyName;
  int? type;
  String? link;
  DateTime? applicationClosedAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  JobResponse({
    this.id,
    this.uuid,
    this.positionTitle,
    this.companyName,
    this.type,
    this.link,
    this.applicationClosedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory JobResponse.fromJson(Map<String, dynamic> json) => JobResponse(
    id: json["id"],
    uuid: json["uuid"],
    positionTitle: json["position_title"],
    companyName: json["company_name"],
    type: json["type"],
    link: json["link"],
    applicationClosedAt: json["application_closed_at"] == null ? null : DateTime.parse(json["application_closed_at"]),
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "position_title": positionTitle,
    "company_name": companyName,
    "type": type,
    "link": link,
    "application_closed_at": applicationClosedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
