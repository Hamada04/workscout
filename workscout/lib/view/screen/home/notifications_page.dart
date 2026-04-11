// import 'package:flutter/material.dart';

// // موديل بسيط للإشعار لتسهيل التعامل مع البيانات مستقبلاً
// class NotificationModel {
//   final String id;
//   final String title;
//   final String description;
//   final String time;
//   final String? actionLabel;

//   NotificationModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.time,
//     this.actionLabel,
//   });
// }

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   // قائمة تجريبية للإشعارات (سيتم جلبها من الـ DB لاحقاً)
//   List<NotificationModel> notifications = [
//     NotificationModel(
//       id: "1",
//       title: "Application Sent",
//       description: "Applications for Telegram companies have entered for company review",
//       time: "25 minutes ago",
//       actionLabel: "Delete",
//     ),
//     NotificationModel(
//       id: "2",
//       title: "Your job notification",
//       description: "Nabilla, there are 8 new jobs for UI/UX Designer in California, USA",
//       time: "2 Hour",
//       actionLabel: "See new job",
//     ),
//     NotificationModel(
//       id: "3",
//       title: "Your job notification",
//       description: "Applications for Skype have entered for company review",
//       time: "1 Day",
//       actionLabel: "Application details",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF334E58)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: notifications.isEmpty 
//           ? _buildEmptyState() 
//           : _buildNotificationsList(),
//     );
//   }

//   // واجهة القائمة مع خاصية الحذف بالسحب (Dismissible)
//   Widget _buildNotificationsList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(20),
//       itemCount: notifications.length,
//       itemBuilder: (context, index) {
//         final item = notifications[index];
//         return Dismissible(
//           key: Key(item.id),
//           direction: DismissDirection.endToStart, // السحب من اليمين لليسار للحذف
//           onDismissed: (direction) {
//             setState(() {
//               notifications.removeAt(index);
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Notification deleted"), duration: Duration(seconds: 1)),
//             );
//           },
//           background: Container(
//             alignment: Alignment.centerRight,
//             padding: const EdgeInsets.only(right: 20),
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: Colors.red.shade400,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: const Icon(Icons.delete, color: Colors.white),
//           ),
//           child: _buildNotificationCard(item),
//         );
//       },
//     );
//   }

//   // كرت الإشعار
//   Widget _buildNotificationCard(NotificationModel item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
//         ],
//         border: Border.all(color: Colors.grey.shade100),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CircleAvatar(
//             backgroundColor: Color(0xFFFFF9F2),
//             radius: 25,
//             child: Icon(Icons.notifications_none, color: Colors.orange),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                     Text(item.time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   item.description,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
//                 ),
//                 if (item.actionLabel != null && item.actionLabel != "Delete")
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         side: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       child: Text(item.actionLabel!, style: const TextStyle(color: Colors.black, fontSize: 12)),
//                     ),
//                   ),
//                 if (item.actionLabel == "Delete")
//                    Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                          // منطق الحذف اليدوي بالضغط
//                       }, 
//                       child: const Text("Delete", style: TextStyle(color: Colors.red, fontSize: 12))
//                     ),
//                   )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // واجهة "لا توجد إشعارات"
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // يمكنك استبدال هذا بـ Image.asset للصورة الموجودة في image_7e7543.png
//           const Icon(Icons.notifications_off_outlined, size: 100, color: Colors.grey),
//           const SizedBox(height: 20),
//           const Text("No Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           const Text(
//             "You have no notifications at this time\nThank You",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// تأكد من استيراد صفحة العرض
import 'offer_letter_page.dart'; 

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final String? actionLabel;
  final String? type; // نوع الإشعار (مثلاً: 'offer' أو 'info')

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.actionLabel,
    this.type,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // القائمة المحدثة مع إضافة نوع "عرض العمل"
  List<NotificationModel> notifications = [
    NotificationModel(
      id: "1",
      type: "info",
      title: "Application Sent",
      description: "Applications for Telegram companies have entered for company review",
      time: "25 minutes ago",
      actionLabel: "Delete",
    ),
    NotificationModel(
      id: "2",
      type: "offer", // هذا النوع سيفتح صفحة الـ Offer Letter
      title: "Congratulations! Job Offer",
      description: "Nabilla, Netflix has sent you an offer letter for the UI/UX Designer position",
      time: "2 Hour",
      actionLabel: "Review Offer",
    ),
    NotificationModel(
      id: "3",
      type: "info",
      title: "Your job notification",
      description: "Applications for Skype have entered for company review",
      time: "1 Day",
      actionLabel: "Application details",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
      body: notifications.isEmpty 
          ? _buildEmptyState() 
          : _buildNotificationsList(),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final item = notifications[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              notifications.removeAt(index);
            });
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
          child: _buildNotificationCard(item),
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationModel item) {
    return InkWell(
      onTap: () {
        // إذا كان نوع الإشعار 'offer'، ننتقل لصفحة الـ Offer Letter
        if (item.type == 'offer') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OfferLetterPage()),
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
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
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
                      Text(item.time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
                  ),
                  if (item.actionLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: item.type == 'offer' 
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OfferLetterPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF334E58),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: Text(item.actionLabel!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              if (item.actionLabel == "Delete") {
                                // منطق الحذف اليدوي
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              item.actionLabel!, 
                              style: TextStyle(
                                color: item.actionLabel == "Delete" ? Colors.red : Colors.black, 
                                fontSize: 12
                              )
                            ),
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