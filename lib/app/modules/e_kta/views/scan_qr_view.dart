import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/result_qr/views/result_qr_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrView extends StatefulWidget {
  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  MobileScannerController controller = MobileScannerController();
  bool isFlashOn = false;

  void _toggleFlash() {
    controller.toggleTorch();
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 350.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral02Color,
        title: Text(
          'Scan QR',
          style: semiBoldText16.copyWith(color: neutral04Color),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: MobileScanner(
                  controller: controller,
                  onDetect: (barcodeCapture) {
                    final String code = barcodeCapture.barcodes.first.rawValue ?? '---';
                    RegExp regExp = RegExp(r'user/(\d+)/membership-status');
                    Match? match = regExp.firstMatch(code);
                    String uid = match?.group(1) ?? "";
                    if (RegExp(r'^\d+$').hasMatch(uid)) {
                      Get.to(
                        () => ResultQrView(uid: uid),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 100),
                      );
                    } else {
                      if (SnackbarController.isSnackbarBeingShown == false) {
                        customSnackbar("Not an E-KTA Qr Code");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
              color: Colors.white,
              onPressed: _toggleFlash,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
