import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';
import 'package:maritimmuda_connect/themes.dart';
// import 'package:timeago/timeago.dart' as timeago;

class CatalogCard extends StatefulWidget {
  const CatalogCard({
    super.key,
    required this.productList,
    required this.onTap,
  });

  final Product productList;
  final Function() onTap;

  @override
  State<CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends State<CatalogCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp() {
    setState(() {
      _isPressed = false;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  void onPressed() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: _onTapUp,
        onTapCancel: _onTapCancel,
        onTapDown: _onTapDown,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: neutral01Color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "$baseUrlImage/${widget.productList.image}",
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.productList.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: semiBoldText16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.access_time_sharp,
                      //       color: primaryDarkBlueColor,
                      //       size: 20,
                      //     ),
                      //     const SizedBox(width: 5),
                      //     Text(
                      //       timeago.format(
                      //           widget.productList.updatedAt ?? DateTime.now()),
                      //       style:
                      //           regulerText12.copyWith(color: neutral03Color),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryDarkBlueColor),
                        ),
                        child: Text(
                          rupiahFormat.format(
                              int.parse(widget.productList.price ?? "0")),
                          style:
                              boldText14.copyWith(color: primaryDarkBlueColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.shopping_cart)) //unimplemented onPressed
                        //for when we have a checkout/payment system
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
