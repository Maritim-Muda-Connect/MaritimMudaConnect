import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) =>
    GeneralResponse.fromJson(json.decode(str));

String generalResponseToJson(GeneralResponse data) =>
    json.encode(data.toJson());

class GeneralResponse {
  User? user;
  Map<String, String>? provinces;
  Map<String, String>? expertises;

  GeneralResponse({
    this.user,
    this.provinces,
    this.expertises,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        provinces: Map.from(json["provinces"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        expertises: Map.from(json["expertises"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "provinces":
            Map.from(provinces!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "expertises": Map.from(expertises!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
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
  String? identityCardLink;
  String? paymentLink;
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
    this.photoLink,
    this.identityCardLink,
    this.paymentLink,
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
        photoLink: json["photo_link"],
        identityCardLink: json["identity_card_link"],
        paymentLink: json["payment_link"],
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
        "photo_link": photoLink,
        "identity_card_link": identityCardLink,
        "payment_link": paymentLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
