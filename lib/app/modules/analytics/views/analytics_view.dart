import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
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
            _buildMemberGrowthChart(),
            const SizedBox(height: 16),
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
                  Wrap(
                    spacing: 32,
                    runSpacing: 4,
                    children: List.generate(
                      controller.widgets.length,
                      (index) {
                        final widget = controller.widgets[index];
                        final svgPath = controller.svgPaths[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: AnalyticCard(
                            title: widget.label ?? 'No Title',
                            value: widget.value?.toString() ?? 'No Value',
                            svgPath: svgPath,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberGrowthChart() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: primaryBlueColor.withOpacity(0.1),
      ),
      child: SafeArea(
        bottom: false, // Prevent bottom padding
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Prevent expansion
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Member Growth',
                    style: boldText20.copyWith(color: neutral04Color),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Obx(() {
                  if (controller.userCounts.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryBlueColor,
                      ),
                    );
                  }
                  
                  // Calculate max value more efficiently
                  final maxCount = controller.userCounts.fold<int>(
                    0, 
                    (prev, curr) => prev > curr ? prev : curr
                  );
                  
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        controller.userCounts.length,
                        (index) {
                          final userCount = controller.userCounts[index];
                          final height = maxCount > 0 
                            ? 120 * (userCount / maxCount) + 32 
                            : 32.0;
                          
                          final dateComponents = controller.months[index].split(' ');
                          final month = dateComponents[0].substring(0, 3);
                          final year = dateComponents[1];
                          final displayDate = '$month\n${year.substring(2)}';
                              
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ChartBar(
                              value: userCount.toString(),
                              height: height,
                              color: primaryBlueColor.withValues(alpha: 0.6),
                              month: displayDate,
                              isSelected: index == 0,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
              // Info row at bottom
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: neutral04Color),
                    const SizedBox(width: 8),
                    Text(
                      'Scroll horizontally to view more',
                      style: regulerText12.copyWith(color: neutral04Color.withValues(alpha: 0.3)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
