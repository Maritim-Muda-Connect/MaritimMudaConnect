// To parse this JSON data, do
//
//     final memberResponse = memberResponseFromJson(jsonString);

import 'dart:convert';

MemberResponse memberResponseFromJson(String str) =>
    MemberResponse.fromJson(json.decode(str));

String memberResponseToJson(MemberResponse data) => json.encode(data.toJson());

class MemberResponse {
  bool? success;
  List<Member>? members;
  Meta? meta;

  MemberResponse({
    this.success,
    this.members,
    this.meta,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
        success: json["success"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Member {
  int? id;
  String? uuid;
  String? uid;
  int? serialNumber;
  String? name;
  String? locale;
  int? provinceId;
  String? email;
  int? firstExpertiseId;
  int? secondExpertiseId;
  dynamic bio;
  String? photoLink;

  Member({
    this.id,
    this.uuid,
    this.uid,
    this.serialNumber,
    this.name,
    this.locale,
    this.provinceId,
    this.email,
    this.firstExpertiseId,
    this.secondExpertiseId,
    this.bio,
    this.photoLink,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        uuid: json["uuid"],
        uid: json["uid"],
        serialNumber: json["serial_number"],
        name: json["name"],
        locale: json["locale"],
        provinceId: json["province_id"],
        email: json["email"],
        firstExpertiseId: json["first_expertise_id"],
        secondExpertiseId: json["second_expertise_id"],
        bio: json["bio"],
        photoLink: json["photo_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "uid": uid,
        "serial_number": serialNumber,
        "name": name,
        "locale": locale,
        "province_id": provinceId,
        "email": email,
        "first_expertise_id": firstExpertiseId,
        "second_expertise_id": secondExpertiseId,
        "bio": bio,
        "photo_link": photoLink,
      };
}

class Meta {
  int? currentPage;
  int? lastPage;
  int? total;
  int? perPage;

  Meta({
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        total: json["total"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "total": total,
        "per_page": perPage,
      };
}
