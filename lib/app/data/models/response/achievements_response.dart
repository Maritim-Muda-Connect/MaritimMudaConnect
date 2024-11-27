import 'dart:convert';

List<AchievementsResponse> achievementsResponseFromJson(String str) => List<AchievementsResponse>.from(json.decode(str).map((x) => AchievementsResponse.fromJson(x)));

String achievementsResponseToJson(List<AchievementsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AchievementsResponse {
  int? id;
  String? uuid;
  int? userId;
  String? awardName;
  String? appreciator;
  String? eventName;
  String? eventLevel;
  DateTime? achievedAt;
  int? orderColumn;

  AchievementsResponse({
    this.id,
    this.uuid,
    this.userId,
    this.awardName,
    this.appreciator,
    this.eventName,
    this.eventLevel,
    this.achievedAt,
    this.orderColumn,
  });

  factory AchievementsResponse.fromJson(Map<String, dynamic> json) => AchievementsResponse(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    awardName: json["award_name"],
    appreciator: json["appreciator"],
    eventName: json["event_name"],
    eventLevel: json["event_level"],
    achievedAt: json["achieved_at"] == null ? null : DateTime.parse(json["achieved_at"]),
    orderColumn: json["order_column"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "award_name": awardName,
    "appreciator": appreciator,
    "event_name": eventName,
    "event_level": eventLevel,
    "achieved_at": achievedAt?.toIso8601String(),
    "order_column": orderColumn,
  };
}
