// // To parse this JSON data, do
// //
// //     final organizationsRequest = organizationsRequestFromJson(jsonString);

// import 'dart:convert';

// OrganizationsRequest organizationsRequestFromJson(String str) =>
//     OrganizationsRequest.fromJson(json.decode(str));

// String organizationsRequestToJson(OrganizationsRequest data) =>
//     json.encode(data.toJson());

// class OrganizationsRequest {
//   bool? success;
//   Data? data;

//   OrganizationsRequest({
//     this.success,
//     this.data,
//   });

//   factory OrganizationsRequest.fromJson(Map<String, dynamic> json) =>
//       OrganizationsRequest(
//         success: json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   int? userId;
//   String? organizationName;
//   String? role;
//   DateTime? periodStartDate;
//   DateTime? periodEndDate;
//   String? uuid;
//   int? orderColumn;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   int? id;

//   Data({
//     this.userId,
//     this.organizationName,
//     this.role,
//     this.periodStartDate,
//     this.periodEndDate,
//     this.uuid,
//     this.orderColumn,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         userId: json["user_id"],
//         organizationName: json["organization_name"],
//         role: json["role"],
//         periodStartDate: json["period_start_date"] == null
//             ? null
//             : DateTime.parse(json["period_start_date"]),
//         periodEndDate: json["period_end_date"] == null
//             ? null
//             : DateTime.parse(json["period_end_date"]),
//         uuid: json["uuid"],
//         orderColumn: json["order_column"],
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "organization_name": organizationName,
//         "role": role,
//         "period_start_date": periodStartDate?.toIso8601String(),
//         "period_end_date": periodEndDate?.toIso8601String(),
//         "uuid": uuid,
//         "order_column": orderColumn,
//         "updated_at": updatedAt?.toIso8601String(),
//         "created_at": createdAt?.toIso8601String(),
//         "id": id,
//       };
// }

// To parse this JSON data, do
//
//     final organizationsRequest = organizationsRequestFromJson(jsonString);

import 'dart:convert';

OrganizationsRequest organizationsRequestFromJson(String str) =>
    OrganizationsRequest.fromJson(json.decode(str));

String organizationsRequestToJson(OrganizationsRequest data) =>
    json.encode(data.toJson());

class OrganizationsRequest {
  String? organizationName;
  String? role;
  DateTime? periodStartDate;
  DateTime? periodEndDate;

  OrganizationsRequest({
    this.organizationName,
    this.role,
    this.periodStartDate,
    this.periodEndDate,
  });

  factory OrganizationsRequest.fromJson(Map<String, dynamic> json) =>
      OrganizationsRequest(
        organizationName: json["organization_name"],
        role: json["role"],
        periodStartDate: json["period_start_date"] == null
            ? null
            : DateTime.parse(json["period_start_date"]),
        periodEndDate: json["period_end_date"] == null
            ? null
            : DateTime.parse(json["period_end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "organization_name": organizationName,
        "role": role,
        "period_start_date": periodStartDate?.toIso8601String(),
        "period_end_date": periodEndDate?.toIso8601String(),
      };
}
