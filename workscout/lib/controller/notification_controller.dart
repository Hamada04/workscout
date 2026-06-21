import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/data/model/notification_model.dart';
import 'package:workscout/services/api_client.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final response = await ApiClient.get('/notifications/my-notifications');
      final List<dynamic> data = response is List ? response : (response['notifications'] ?? []);
      notifications.assignAll(
        data.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)),
      );
    } catch (e) {
      debugPrint('[NotificationController] fetch error: $e');
      Get.snackbar(
        'Sync Error',
        'Could not load notifications.\n$e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
