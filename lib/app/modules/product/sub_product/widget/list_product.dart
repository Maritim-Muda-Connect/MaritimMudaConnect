import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:maritimmuda_connect/app/data/utils/price.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListCatalog extends StatefulWidget {
  const ListCatalog({
    super.key,
    required this.productList,
    required this.onTap,
  });

  final Product productList;
  final Function() onTap;

  @override
  State<ListCatalog> createState() => _ListCatalogState();
}

class _ListCatalogState extends State<ListCatalog> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: _onTapUp,
          onTapCancel: _onTapCancel,
          onTapDown: _onTapDown,
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "$baseUrlImage/${widget.productList.image}",
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rupiahFormat.format(
                              int.parse(widget.productList.price ?? "0")),
                          style: boldText14.copyWith(color: secondaryRedColor),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.productList.category ?? "",
                          style: boldText14.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '"${widget.productList.name}"',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: boldText14,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          timeago.format(
                              widget.productList.updatedAt ?? DateTime.now()),
                          style: regulerText12.copyWith(color: neutral03Color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: neutral03Color, thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
