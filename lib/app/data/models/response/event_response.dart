import 'dart:convert';



List<Event> eventResponseFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));


String eventResponseToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Event {
  int? id;
  String? uuid;
  String? name;
  String? organizerName;
  String? externalUrl;
  int? type;
  DateTime? startDate;
  DateTime? endDate;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Event({
    this.id,
      this.uuid,
      this.name,
      this.organizerName,
      this.externalUrl,
      this.type,
      this.startDate,
      this.endDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json["id"],
      uuid: json["uuid"],
      name: json["name"],
      organizerName: json["organizer_name"],
      externalUrl: json["external_url"],
      type: json["type"],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      deletedAt: json["deleted_at"]
          // == null
          // ? null
          // : DateTime.parse(json["deleted_at"])
      ,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "organizer_name": organizerName,
        "external_url": externalUrl,
        "type": type,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
