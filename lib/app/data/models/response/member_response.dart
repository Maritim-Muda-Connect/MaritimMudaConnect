import 'dart:convert';

MemberResponse memberResponseFromJson(String str) =>
    MemberResponse.fromJson(json.decode(str));

String memberResponseToJson(MemberResponse data) => json.encode(data.toJson());

class MemberResponse {
  bool? success;
  List<Member>? members;

  MemberResponse({
    this.success,
    this.members,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
        success: json["success"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
      };
}

class Member {
  int? id;
  String? uuid;
  String? name;
  int? provinceId;
  String? email;
  int? firstExpertiseId;
  int? secondExpertiseId;
  dynamic bio;
  String? photoLink;

  Member({
    this.id,
    this.uuid,
    this.name,
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
        name: json["name"],
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
        "name": name,
        "province_id": provinceId,
        "email": email,
        "first_expertise_id": firstExpertiseId,
        "second_expertise_id": secondExpertiseId,
        "bio": bio,
        "photo_link": photoLink,
      };
}
