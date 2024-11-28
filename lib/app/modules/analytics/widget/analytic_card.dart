import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maritimmuda_connect/themes.dart';

class AnalyticCard extends StatelessWidget {
  final String title;
  final String value;
  final String svgPath;

  const AnalyticCard({
    super.key,
    required this.title,
    required this.value, required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,// Tentukan tinggi tetap
      child: Container(
        decoration: BoxDecoration(
          color: neutral01Color, // Sesuaikan warna dengan tema Anda
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul (Title) yang diambil dari label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: mediumText12.copyWith(color: neutral04Color),
                  ),
                  SvgPicture.asset(
                    svgPath, // Menampilkan ikon SVG berdasarkan path
                    width: 16, // Ukuran ikon
                    height: 16, // Ukuran ikon // Warna ikon
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Nilai (Value) yang diambil dari value
              Text(
                value,
                style: boldText24.copyWith(color: neutral04Color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
