import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/points_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class PointsView extends GetView<PointsController> {
  const PointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Points Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryDarkBlueColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: Colors.amber,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Total Points',
                      style: semiBoldText16.copyWith(color: neutral01Color),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                          '${controller.totalPoints.value}',
                          style: boldText32.copyWith(color: neutral01Color),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Points Breakdown Section
              Text(
                'Points Breakdown',
                style: semiBoldText24.copyWith(color: neutral04Color),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: neutral02Color),
                ),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBreakdownItem('Publications',
                            controller.publicationPoints.value, Icons.article),
                        _buildBreakdownItem(
                            'Webinars',
                            controller.webinarPoints.value,
                            Icons.video_camera_front),
                        _buildBreakdownItem('Research',
                            controller.researchPoints.value, Icons.science),
                        _buildBreakdownItem('Awards',
                            controller.awardPoints.value, Icons.emoji_events),
                      ],
                    )),
              ),

              const SizedBox(height: 24),

              // Points Shop Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points Shop',
                    style: semiBoldText24.copyWith(color: neutral04Color),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to full shop page
                    },
                    child: Text(
                      'See All',
                      style: mediumText16.copyWith(color: primaryDarkBlueColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.shopItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.shopItems[index];
                    return Card(
                      margin: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 160,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              size: 32,
                              color: primaryDarkBlueColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              style: semiBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${item.points} pts',
                              style: boldText16.copyWith(
                                  color: primaryDarkBlueColor),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => controller.redeemPoints(item),
                              child: const Text('Redeem'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(String title, int points, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: primaryDarkBlueColor),
          const SizedBox(width: 12),
          Text(title, style: mediumText16),
          const Spacer(),
          Text(
            '$points pts',
            style: boldText14.copyWith(color: primaryDarkBlueColor),
          ),
        ],
      ),
    );
  }
}
