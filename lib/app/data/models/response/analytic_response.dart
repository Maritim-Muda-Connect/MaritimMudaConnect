// To parse this JSON data, do
//
//     final analyticResponse = analyticResponseFromJson(jsonString);

import 'dart:convert';

AnalyticResponse analyticResponseFromJson(String str) => AnalyticResponse.fromJson(json.decode(str));

String analyticResponseToJson(AnalyticResponse data) => json.encode(data.toJson());

class AnalyticResponse {
    User? user;
    List<Widgets>? widgets;
    List<String>? months;
    Map<String, int>? userCounts;
    dynamic announcement;

    AnalyticResponse({
        this.user,
        this.widgets,
        this.months,
        this.userCounts,
        this.announcement,
    });

    factory AnalyticResponse.fromJson(Map<String, dynamic> json) => AnalyticResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        widgets: json["widgets"] == null ? [] : List<Widgets>.from(json["widgets"]!.map((x) => Widgets.fromJson(x))),
        months: json["months"] == null ? [] : List<String>.from(json["months"]!.map((x) => x)),
        userCounts: Map.from(json["userCounts"]!).map((k, v) => MapEntry<String, int>(k, v)),
        announcement: json["announcement"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x.toJson())),
        "months": months == null ? [] : List<dynamic>.from(months!.map((x) => x)),
        "userCounts": Map.from(userCounts!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "announcement": announcement,
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
    String? locale;
    DateTime? emailVerifiedAt;
    String? placeOfBirth;
    DateTime? dateOfBirth;
    dynamic linkedinProfile;
    dynamic instagramProfile;
    int? provinceId;
    int? firstExpertiseId;
    int? secondExpertiseId;
    dynamic permanentAddress;
    dynamic residenceAddress;
    dynamic bio;
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
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        linkedinProfile: json["linkedin_profile"],
        instagramProfile: json["instagram_profile"],
        provinceId: json["province_id"],
        firstExpertiseId: json["first_expertise_id"],
        secondExpertiseId: json["second_expertise_id"],
        permanentAddress: json["permanent_address"],
        residenceAddress: json["residence_address"],
        bio: json["bio"],
        isAdmin: json["is_admin"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class Widgets {
    String? label;
    dynamic value;
    String? icon;
    String? action;

    Widgets({
        this.label,
        this.value,
        this.icon,
        this.action,
    });

    factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
        label: json["label"],
        value: json["value"],
        icon: json["icon"],
        action: json["action"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "icon": icon,
        "action": action,
    };
}
