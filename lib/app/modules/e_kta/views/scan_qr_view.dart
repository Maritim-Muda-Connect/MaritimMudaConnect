import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/result_qr/views/result_qr_view.dart';
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        RegExp regExp = RegExp(r'user/(\d+)/membership-status');
        Match? match = regExp.firstMatch(result?.code ?? "");
        String uid = match?.group(1) ?? "";
        Get.to(
          () => ResultQrView(uid: uid),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral02Color,
        title: Text('Scan QR',
            style: semiBoldText16.copyWith(color: neutral04Color)),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
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
