import 'dart:convert';

List<Scholarship> scholarshipFromJson(String str) => List<Scholarship>.from(json.decode(str).map((x) => Scholarship.fromJson(x)));

String scholarshipToJson(List<Scholarship> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scholarship {
  int? id;
  String? uuid;
  String? name;
  String? providerName;
  String? registrationLink;
  DateTime? submissionDeadline;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Scholarship({
    this.id,
    this.uuid,
    this.name,
    this.providerName,
    this.registrationLink,
    this.submissionDeadline,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Scholarship.fromJson(Map<String, dynamic> json) => Scholarship(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    providerName: json["provider_name"],
    registrationLink: json["registration_link"],
    submissionDeadline: DateTime.parse(json["submission_deadline"]),
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "provider_name": providerName,
    "registration_link": registrationLink,
    "submission_deadline": submissionDeadline?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
