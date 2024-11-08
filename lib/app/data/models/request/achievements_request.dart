import 'dart:convert';

AchievementsRequest achievementsRequestFromJson(String str) => AchievementsRequest.fromJson(json.decode(str));

String achievementsRequestToJson(AchievementsRequest data) => json.encode(data.toJson());

class AchievementsRequest {
  String? awardName;
  String? appreciator;
  String? eventName;
  String? eventLevel;
  String? achievedAt;

  AchievementsRequest({
    this.awardName,
    this.appreciator,
    this.eventName,
    this.eventLevel,
    this.achievedAt,
  });

  factory AchievementsRequest.fromJson(Map<String, dynamic> json) => AchievementsRequest(
    awardName: json["award_name"],
    appreciator: json["appreciator"],
    eventName: json["event_name"],
    eventLevel: json["event_level"],
    achievedAt: json["achieved_at"],
  );

  Map<String, dynamic> toJson() => {
    "award_name": awardName,
    "appreciator": appreciator,
    "event_name": eventName,
    "event_level": eventLevel,
    "achieved_at": achievedAt
  };
}
