import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/result_qr/views/result_qr_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrView extends StatefulWidget {
  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;

  void _createQrView(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        RegExp regExp = RegExp(r'user/(\d+)/membership-status');
        Match? match = regExp.firstMatch(result?.code ?? "");
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
      });
    });
  }

  void _toggleFlash() {
    if (controller != null) {
      controller!.toggleFlash();
      setState(() {
        isFlashOn = !isFlashOn;
      });
    }
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
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _createQrView,
                  overlay: QrScannerOverlayShape(
                    borderColor: primaryDarkBlueColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea,
                  ),
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
    controller?.dispose();
    super.dispose();
  }
}
