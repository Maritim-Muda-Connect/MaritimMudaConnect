const String baseUrl = "https://hub.maritimmuda.id/api";

const String baseUrlImage = "https://hub.maritimmuda.id/media";

final Map<String, String> headersNoToken = {
  'Content-Type': 'application/json',
};

Map<String, String> headerWithToken(String token) {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
