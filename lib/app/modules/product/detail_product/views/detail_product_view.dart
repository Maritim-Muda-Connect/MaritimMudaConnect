import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maritimmuda_connect/app/modules/product/widgets/custom_image_view.dart';

import '../controllers/detail_catalog_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key, this.productData});

  final Product? productData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: neutral02Color,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: neutral02Color,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Product Detail'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ZoomableImageView(
                        imageUrl: '$baseUrlImage/${productData?.image}',
                      ),
                      transition: Transition.fadeIn,
                    );
                  },
                  child: Hero(
                    tag: 'productImage${productData?.id}',
                    child: Image.network(
                      '$baseUrlImage/${productData?.image}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productData?.name ?? '',
                      style: semiBoldText28,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryBlueColor),
                          color: neutral01Color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        productData?.category ?? '',
                        style: regulerText16,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Price : ",
                          style: boldText20,
                        ),
                        Text(
                          rupiahFormat
                              .format(int.parse(productData?.price ?? '0')),
                          style: boldText20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: neutral02Color,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                shadowColor: Colors.transparent,
                radius: 0,
                color: neutral01Color,
                width: MediaQuery.of(context).size.width / 2,
                text: 'SHARE',
                textColor: primaryBlueColor,
                onPressed: () async {
                  await Share.share(
                      '${productData?.name}\n\n${productData?.link}');
                },
              ),
              CustomButton(
                  shadowColor: Colors.transparent,
                  radius: 0,
                  width: MediaQuery.of(context).size.width / 2,
                  text: 'BUY',
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        productData?.link ?? 'https://hub.maritimmuda.id'));
                  })
            ],
          ),
        ));
  }
}
