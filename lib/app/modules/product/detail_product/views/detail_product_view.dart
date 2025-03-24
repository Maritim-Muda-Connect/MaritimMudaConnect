import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';
// import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maritimmuda_connect/app/modules/product/widgets/custom_image_view.dart';

import '../controllers/detail_catalog_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key, this.productData});

  final Product? productData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black87),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'productImage${productData?.id}',
              child: GestureDetector(
                onTap: () => Get.to(
                  () => ZoomableImageView(
                      imageUrl: '$baseUrlImage/${productData?.image}'),
                  transition: Transition.fadeIn,
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Image.network(
                    '$baseUrlImage/${productData?.image}',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: neutral01Color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(
                          0, 4), 
                      blurRadius: 12,
                      spreadRadius: -2
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryBlueColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          productData?.category ?? '',
                          style:
                              regulerText14.copyWith(color: primaryBlueColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        productData?.name ?? '',
                        style: semiBoldText28,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: neutral02Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  rupiahFormat.format(
                                      int.parse(productData?.price ?? '0')),
                                  style: boldText24.copyWith(
                                      color: primaryDarkBlueColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: neutral01Color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: (0.05)),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await Share.share(
                      '${productData?.name}\n\n${productData?.link}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: neutral02Color,
                  foregroundColor: primaryBlueColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('SHARE'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      productData?.link ?? 'https://hub.maritimmuda.id'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDarkBlueColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('BUY NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
