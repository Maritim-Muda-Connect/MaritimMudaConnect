import 'dart:convert';

String generalRequestToJson(GeneralRequest data) => json.encode(data.toJson());

class GeneralRequest {
  String name;
  String linkedinProfile;
  String instagramProfile;
  int gender;
  String placeOfBirth;
  String dateOfBirth;
  int firstExpertiseId;
  int secondExpertiseId;
  String permanentAddress;
  String residenceAddress;
  String bio;

  GeneralRequest({
    required this.name,
    required this.linkedinProfile,
    required this.instagramProfile,
    required this.gender,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.firstExpertiseId,
    required this.secondExpertiseId,
    required this.permanentAddress,
    required this.residenceAddress,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "linkedin_profile": linkedinProfile,
        "instagram_profile": instagramProfile,
        "gender": gender,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth,
        "first_expertise_id": firstExpertiseId,
        "second_expertise_id": secondExpertiseId,
        "permanent_address": permanentAddress,
        "residence_address": residenceAddress,
        "bio": bio,
      };
}
