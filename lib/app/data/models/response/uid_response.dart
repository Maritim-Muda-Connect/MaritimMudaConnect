// To parse this JSON data, do
//
//     final uidResponse = uidResponseFromJson(jsonString);

import 'dart:convert';

UidResponse uidResponseFromJson(String str) =>
    UidResponse.fromJson(json.decode(str));

String uidResponseToJson(UidResponse data) => json.encode(data.toJson());

class UidResponse {
  bool? success;
  User? user;
  String? uid;

  UidResponse({
    this.success,
    this.user,
    this.uid,
  });

  factory UidResponse.fromJson(Map<String, dynamic> json) => UidResponse(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
        "uid": uid,
      };
}

class User {
  int? id;
  String? uuid;
  String? uid;
  int? serialNumber;
  String? name;
  int? gender;
  String? email;
  dynamic locale;
  DateTime? emailVerifiedAt;
  String? placeOfBirth;
  DateTime? dateOfBirth;
  String? linkedinProfile;
  String? instagramProfile;
  int? provinceId;
  int? firstExpertiseId;
  int? secondExpertiseId;
  String? permanentAddress;
  String? residenceAddress;
  String? bio;
  int? isAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.uuid,
    this.uid,
    this.serialNumber,
    this.name,
    this.gender,
    this.email,
    this.locale,
    this.emailVerifiedAt,
    this.placeOfBirth,
    this.dateOfBirth,
    this.linkedinProfile,
    this.instagramProfile,
    this.provinceId,
    this.firstExpertiseId,
    this.secondExpertiseId,
    this.permanentAddress,
    this.residenceAddress,
    this.bio,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uuid: json["uuid"],
        uid: json["uid"],
        serialNumber: json["serial_number"],
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        locale: json["locale"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        linkedinProfile: json["linkedin_profile"],
        instagramProfile: json["instagram_profile"],
        provinceId: json["province_id"],
        firstExpertiseId: json["first_expertise_id"],
        secondExpertiseId: json["second_expertise_id"],
        permanentAddress: json["permanent_address"],
        residenceAddress: json["residence_address"],
        bio: json["bio"],
        isAdmin: json["is_admin"],
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
        "uid": uid,
        "serial_number": serialNumber,
        "name": name,
        "gender": gender,
        "email": email,
        "locale": locale,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "linkedin_profile": linkedinProfile,
        "instagram_profile": instagramProfile,
        "province_id": provinceId,
        "first_expertise_id": firstExpertiseId,
        "second_expertise_id": secondExpertiseId,
        "permanent_address": permanentAddress,
        "residence_address": residenceAddress,
        "bio": bio,
        "is_admin": isAdmin,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
