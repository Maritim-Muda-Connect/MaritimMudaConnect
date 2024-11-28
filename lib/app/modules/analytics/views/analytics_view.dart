import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/analytics/widget/analytic_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/analytics_controller.dart';
import '../widget/chart_bar.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: primaryBlueColor.withOpacity(0.3),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Growth Member',
                        style: boldText20.copyWith(color: neutral04Color),
                      ),
                      const SizedBox(height: 16),
                      // Menampilkan grafik menggunakan ChartBar
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(controller.userCounts.length, (index) {
                            return Obx(() {
                              final userCount = controller.userCounts.isNotEmpty
                                  ? controller.userCounts[index].toString()
                                  : ''; // Tampilkan nilai userCount atau kosong jika tidak ada data

                              final height = controller.userCounts.isNotEmpty
                                  ? (controller.userCounts[index] / 10).clamp(10.0, 240.0)
                                  : 10.0; // Normalisasi tinggi bar (misalnya max 240)

                              final month = controller.months.isNotEmpty
                                  ? controller.months[index].substring(0, 3)
                                  : '';

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ChartBar(
                                  value: userCount,
                                  height: height,
                                  color: primaryBlueColor,
                                  month: month, // Sesuaikan dengan bulan
                                ),
                              );
                            });
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Menampilkan widget menggunakan AnalyticCard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analytics Overview',
                    style: boldText20.copyWith(color: neutral04Color),
                  ),
                  
                  const SizedBox(height: 16),
                  // GridView atau ListView untuk menampilkan AnalyticCard
                  Wrap(
                    spacing: 16, // Jarak antar elemen dalam baris
                    runSpacing: 4, // Jarak antar baris
                    children: List.generate(controller.widgets.length, (index) {
                      final widget = controller.widgets[index];
                      final svgPath = controller.svgPaths[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Mengurangi padding vertikal
                        child: AnalyticCard(
                          title: widget.label ?? 'No Title',
                          value: widget.value?.toString() ?? 'No Value', 
                          svgPath: svgPath,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
