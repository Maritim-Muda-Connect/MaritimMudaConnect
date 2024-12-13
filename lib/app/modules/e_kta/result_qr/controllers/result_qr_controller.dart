import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/result_qr_response.dart';
import 'package:maritimmuda_connect/app/data/services/ekta/result_qr_service.dart';

class ResultQrController extends GetxController {
  var isLoading = true.obs;
  var memberQrData = ResultQrResponse().obs;
  final String defaultAvatar =
      "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg";

  Future<void> fetchMemberQr(String uid) async {
    try {
      isLoading(true);
      var data = await ResultQrService().fetchMemberQr(uid);
      memberQrData(data);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
