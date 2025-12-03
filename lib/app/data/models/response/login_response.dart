import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? message;
  User? user;
  String? token;

  LoginResponse({
    this.message,
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
        "token": token,
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
  String? citizenship;
  int? isAdmin;

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
    this.citizenship,
    this.isAdmin,
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
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : null,
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"] != null
            ? DateTime.parse(json["date_of_birth"])
            : null,
        linkedinProfile: json["linkedin_profile"],
        instagramProfile: json["instagram_profile"],
        provinceId: json["province_id"],
        firstExpertiseId: json["first_expertise_id"],
        secondExpertiseId: json["second_expertise_id"],
        permanentAddress: json["permanent_address"],
        residenceAddress: json["residence_address"],
        bio: json["bio"],
        isAdmin: json["is_admin"],
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
      };
}
