import 'dart:convert';

String deleteAccountRequestToJson(DeleteAccountRequest data) => json.encode(data.toJson());

class DeleteAccountRequest {
  String password;
  String confirmDelete;
  String reason;

  DeleteAccountRequest({
    required this.password,
    required this.confirmDelete,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
        "password": password,
        "confirm_delete": confirmDelete,
        "reason": reason,
      };
}
