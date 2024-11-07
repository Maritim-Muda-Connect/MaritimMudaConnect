import 'dart:convert';

PublicationRequest publicationRequestFromJson(String str) =>
    PublicationRequest.fromJson(json.decode(str));

String publicationRequestToJson(PublicationRequest data) => json.encode(data.toJson());

class PublicationRequest {
  String? title;
  String? authorName;
  int? type;
  String? publisher;
  String? city;
  String? publishDate;
  String? firstPage;

  PublicationRequest({
    this.title,
    this.authorName,
    this.type,
    this.publisher,
    this.city,
    this.publishDate,
    this.firstPage,
  });

  factory PublicationRequest.fromJson(Map<String, dynamic> json) => PublicationRequest(
    title: json["title"],
    authorName: json["author_name"],
    type: json["type"],
    publisher: json["publisher"],
    city: json["city"],
    publishDate: json["publish_date"],
    firstPage: json["first_page"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author_name": authorName,
    "type": type,
    "publisher": publisher,
    "city": city,
    "publish_date": publishDate,
    "first_page": firstPage,
  };


}
