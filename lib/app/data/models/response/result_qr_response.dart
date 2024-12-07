import 'dart:convert';

ResultQrResponse resultQrResponseFromJson(String str) =>
    ResultQrResponse.fromJson(json.decode(str));

String resultQrResponseToJson(ResultQrResponse data) =>
    json.encode(data.toJson());

class ResultQrResponse {
  bool? success;
  User? user;
  String? membershipStatus;
  DateTime? membershipVerifiedAt;
  DateTime? membershipExpiredAt;

  ResultQrResponse({
    this.success,
    this.user,
    this.membershipStatus,
    this.membershipVerifiedAt,
    this.membershipExpiredAt,
  });

  factory ResultQrResponse.fromJson(Map<String, dynamic> json) =>
      ResultQrResponse(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        membershipStatus: json["membership_status"],
        membershipVerifiedAt: json["membership_verified_at"] == null
            ? null
            : DateTime.parse(json["membership_verified_at"]),
        membershipExpiredAt: json["membership_expired_at"] == null
            ? null
            : DateTime.parse(json["membership_expired_at"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
        "membership_status": membershipStatus,
        "membership_verified_at": membershipVerifiedAt?.toIso8601String(),
        "membership_expired_at": membershipExpiredAt?.toIso8601String(),
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
  String? photoLink;
  DateTime? createdAt;
  DateTime? updatedAt;
  Membership? membership;

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
    this.photoLink,
    this.createdAt,
    this.updatedAt,
    this.membership,
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
        photoLink: json["photo_link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
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
        "photo_link": photoLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "membership": membership?.toJson(),
      };
}

class Membership {
  int? id;
  int? userId;
  DateTime? verifiedAt;
  DateTime? expiredAt;

  Membership({
    this.id,
    this.userId,
    this.verifiedAt,
    this.expiredAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        id: json["id"],
        userId: json["user_id"],
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "verified_at": verifiedAt?.toIso8601String(),
        "expired_at": expiredAt?.toIso8601String(),
      };
}
