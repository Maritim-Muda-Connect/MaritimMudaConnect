import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';

class CatalogListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const CatalogListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: neutral01Color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(24.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "$baseUrlImage/${product.image}",
              width: 50,
              height: 50,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: semiBoldText16,
              ),
              const SizedBox(height: 10),
              Text(
                rupiahFormat.format(int.parse(product.price ?? "0")),
                style: boldText14.copyWith(color: primaryDarkBlueColor),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onTap,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
