import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maritimmuda_connect/themes.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback? onTap;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
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
    widget.onTap!();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
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
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: neutral01Color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(widget.icon, width: 32, height: 32),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: regulerText16.copyWith(
                        fontSize: 18, color: neutral04Color),
                  ),
                  Icon(Icons.chevron_right, color: neutral03Color)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
