import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
import 'package:maritimmuda_connect/app/data/services/ekta/result_qr_service.dart';
import 'package:url_launcher/url_launcher.dart';

class EKtaController extends GetxController {
  final RxInt currentPage = 0.obs;
  final String defaultAvatar =
      "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg";
  String svgString = '';

  var ektaData = GeneralResponse().obs;
  var sliderValue = 0.0.obs;
  var isLoading = true.obs;
  var qrCodeBase64 = ''.obs;

  void updateSliderValue(double value) {
    sliderValue.value = value;
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getEkta();
  }

  Future<void> getEkta() async {
    try {
      isLoading(true);

      var response = await ResultQrService().fetchEkta();
      ektaData(response);
      qrCodeBase64.value = ektaData.value.qrCodeUrl ?? '';
      svgString =
          qrCodeBase64.value.replaceFirst("data:image/svg+xml;base64,", "");
    } finally {
      isLoading(false);
    }
  }

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception("Could not launch $url)");
    }
  }
}
