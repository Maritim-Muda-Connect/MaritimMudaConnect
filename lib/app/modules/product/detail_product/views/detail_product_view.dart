import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detail_catalog_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key,  this.productData});
  Product? productData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Detail Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await Share.share('${productData?.name}\n\n${productData?.link}');
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productData?.category ?? '',
              style: regulerText14,
            ),
            SizedBox(height: 8),
            Text(
              productData?.name ?? '',
              style: boldText32,
            ),
            SizedBox(height: 60),
            // Menggunakan Image.asset untuk menampilkan gambar
            Image.network(
              '$baseUrlImage/${productData?.image}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 60),
            Text(
              rupiahFormat.format(int.parse(productData?.price ?? '0')),
              style: boldText24,
            ),
            const SizedBox(height: 200,),
            CustomButton(text: 'BUY', onPressed: () async {
              await launchUrl(Uri.parse(productData?.link ?? 'https://hub.maritimmuda.id'));
            }
            )
            // ... (sisa kode tetap sama)
          ],
        ),
      ),
    );
  }
}
