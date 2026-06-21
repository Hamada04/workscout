import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/notification_controller.dart';
import 'package:workscout/data/model/notification_model.dart';
import 'package:workscout/view/screen/home/offer_letter_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  String _timeAgo(String createdAt) {
    try {
      final date = DateTime.parse(createdAt);
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
      if (diff.inHours < 24) return '${diff.inHours} hour ago';
      if (diff.inDays < 7) return '${diff.inDays} day ago';
      return '${diff.inDays ~/ 7} week ago';
    } catch (_) {
      return createdAt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF334E58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }
        return _buildNotificationsList(controller);
      }),
    );
  }

  Widget _buildNotificationsList(NotificationController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final item = controller.notifications[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            controller.notifications.removeAt(index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Notification deleted"), duration: Duration(seconds: 1)),
            );
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: _buildNotificationCard(context, item),
        );
      },
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationModel item) {
    return InkWell(
      onTap: () {
        if (item.type == 'offer' && item.relatedId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OfferLetterPage(offerId: item.relatedId!)),
          );
        }
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFFFF9F2),
              radius: 25,
              child: Icon(Icons.notifications_none, color: Colors.orange),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(_timeAgo(item.createdAt), style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.message,
                    style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
                  ),
                  if (item.type == 'offer')
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                        if (item.relatedId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OfferLetterPage(offerId: item.relatedId!)),
                          );
                        }
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF334E58),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: const Text("Review Offer", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_off_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text("No Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            "You have no notifications at this time\nThank You",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
