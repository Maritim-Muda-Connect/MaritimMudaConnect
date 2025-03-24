import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievements/controllers/achievements_controller.dart';

class ShopItem {
  final String name;
  final int points;
  final IconData icon;

  ShopItem({
    required this.name,
    required this.points,
    required this.icon,
  });
}

class PointsValue {
  static const Map<String, int> achievementPoints = {
    'Publication': 15,
    'International Publication': 25,
    'National Conference': 10,
    'International Conference': 20,
    'Workshop': 5,
    'Webinar': 3,
    'Research Project': 12,
    'Research Grant': 20,
    'Award': 15,
    'National Award': 25,
    'International Award': 35,
  };

  static int calculatePoints(String achievementType, {String? scope}) {
    final type = achievementType.toLowerCase();
    final achievementScope = (scope ?? '').toLowerCase();

    if (type.contains('publication')) {
      return achievementScope.contains('international')
          ? achievementPoints['International Publication']!
          : achievementPoints['Publication']!;
    }
    // Add similar logic for other achievement types
    return achievementPoints['Award']!; // Default points
  }
}

class PointsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
  final achievementsController = Get.find<AchievementsController>();

  // Points tracking
  final totalPoints = 0.obs;
  final publicationPoints = 0.obs;
  final webinarPoints = 0.obs;
  final researchPoints = 0.obs;
  final awardPoints = 0.obs;

  // Shop items
  final shopItems = <ShopItem>[
    ShopItem(
      name: 'Premium Membership',
      points: 1000,
      icon: Icons.star,
    ),
    ShopItem(
      name: 'Workshop Access',
      points: 500,
      icon: Icons.school,
    ),
    ShopItem(
      name: 'Certificate',
      points: 300,
      icon: Icons.card_membership,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    setupListeners();
    // calculatePointsFromAchievements();
  }

  void setupListeners() {
    // Recalculate points whenever achievements change
    ever(achievementsController.achievementsData, (_) {
      // calculatePointsFromAchievements();
    });
  }

  // void calculatePointsFromAchievements() {
  //   try {
  //     isLoading(true);
  //     var publications = 0;
  //     var conferences = 0;
  //     var awards = 0;
  //     var research = 0;

  //     for (var achievement in achievementsController.achievementsData) {
  //       final type = achievement.awardName?.toLowerCase() ?? '';
  //       final scope = achievement.scope?.toLowerCase() ?? '';

  //       if (type.contains('publication')) {
  //         publications +=
  //             PointsValue.calculatePoints('Publication', scope: scope);
  //       } else if (type.contains('conference')) {
  //         conferences +=
  //             PointsValue.calculatePoints('Conference', scope: scope);
  //       } else if (type.contains('award')) {
  //         awards += PointsValue.calculatePoints('Award', scope: scope);
  //       } else if (type.contains('research')) {
  //         research += PointsValue.calculatePoints('Research', scope: scope);
  //       }
  //     }
  //     publicationPoints.value = publications;
  //     webinarPoints.value = conferences;
  //     researchPoints.value = research;
  //     awardPoints.value = awards;

  //     // Update total points
  //     calculateTotalPoints();
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<bool> canRedeemPoints(int amount) async {
    // Recalculate points to ensure current value
    // calculatePointsFromAchievements();
    return totalPoints.value >= amount;
  }

  void calculateTotalPoints() {
    totalPoints.value = publicationPoints.value +
        webinarPoints.value +
        researchPoints.value +
        awardPoints.value;
  }

  void redeemPoints(ShopItem item) {
    if (totalPoints.value >= item.points) {
      Get.dialog(
        AlertDialog(
          title: const Text('Confirm Redemption'),
          content: Text('Redeem ${item.name} for ${item.points} points?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (await canRedeemPoints(item.points)) {
                  Get.back();
                  Get.snackbar(
                    "Successfully Redeemed",
                    '${item.name} redeemed successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
                totalPoints.value -= item.points;
                Get.back();
                Get.snackbar(
                  'Success',
                  '${item.name} redeemed successfully!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar(
        'Error',
        'Not enough points',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
