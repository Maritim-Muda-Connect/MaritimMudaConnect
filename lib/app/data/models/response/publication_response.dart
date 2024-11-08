import 'dart:convert';

List<PublicationResponse> publicationResponseFromJson(String str) => List<PublicationResponse>.from(json.decode(str).map((x) => PublicationResponse.fromJson(x)));

String publicationResponseToJson(List<PublicationResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicationResponse {
  int? id;
  String? uuid;
  int? userId;
  String? title;
  String? authorName;
  int? type;
  String? publisher;
  String? city;
  DateTime? publishDate;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;

  PublicationResponse({
    this.id,
    this.uuid,
    this.userId,
    this.title,
    this.authorName,
    this.type,
    this.publisher,
    this.city,
    this.publishDate,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
  });

  factory PublicationResponse.fromJson(Map<String, dynamic> json) => PublicationResponse(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    title: json["title"],
    authorName: json["author_name"],
    type: json["type"],
    publisher: json["publisher"],
    city: json["city"],
    publishDate: json["publish_date"] == null ? null : DateTime.parse(json["publish_date"]),
    orderColumn: json["order_column"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "title": title,
    "author_name": authorName,
    "type": type,
    "publisher": publisher,
    "city": city,
    "publish_date": publishDate?.toIso8601String(),
    "order_column": orderColumn,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
