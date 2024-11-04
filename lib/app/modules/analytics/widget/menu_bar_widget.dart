import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Material untuk menggunakan Colors
import 'package:maritimmuda_connect/themes.dart';

class MenuBarWidget extends StatefulWidget {
  final String menu;
  final bool isSelected; // Tambahkan parameter ini
  const MenuBarWidget({super.key, required this.menu, this.isSelected = false}); // Default ke false

  @override
  _MenuBarWidgetState createState() => _MenuBarWidgetState();
}

class _MenuBarWidgetState extends State<MenuBarWidget> {
  late bool isSelected; // Gunakan late untuk mendeklarasikan variabel

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected; // Inisialisasi dengan nilai dari widget
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle status saat ditekan
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? primaryDarkBlueColor : neutral01Color, // Ganti warna berdasarkan status
        ),
        child: Text(
          widget.menu,
          style: semiBoldText8.copyWith(
            color: isSelected ? neutral01Color : neutral04Color, // Ganti warna teks berdasarkan status
          ),
        ),
      ),
    );
  }
}
