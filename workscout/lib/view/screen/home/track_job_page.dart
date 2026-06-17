// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// // استيراد الموديلات والبيانات الخاصة بك
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_details.dart';


// class TrackJobPage extends StatefulWidget {
//   const TrackJobPage({super.key});

//   @override
//   State<TrackJobPage> createState() => _TrackJobPageState();
// }

// class _TrackJobPageState extends State<TrackJobPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: null, // التبويبات ستكون في الـ Bottom الخاص بالـ AppBar
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xFF334E58),
//           indicatorWeight: 3,
//           labelColor: const Color(0xFF334E58),
//           unselectedLabelColor: Colors.grey,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           tabs: const [
//             Tab(text: "Applied Job Details"),
//             Tab(text: "Save Job"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildAppliedJobsTab(),
//           _buildSavedJobsTab(),
//         ],
//       ),
//     );
//   }

//   // --- التبويب الأول: طلبات التوظيف المرسلة ---
//   Widget _buildAppliedJobsTab() {
//     // محاكاة لبيانات الطلبات مع حالتها (Application Submitted, Interview, Rejected)
//     final List<Map<String, dynamic>> appliedJobs = [
//       {
//         "job": allJobs[0], // Netflix UI Designer
//         "status": "Application Submitted",
//         "statusColor": Colors.blueGrey,
//       },
//       {
//         "job": allJobs[1], // Telegram UI Designer
//         "status": "Interview",
//         "statusColor": Colors.red,
//       },
//       {
//         "job": allJobs[0], // Netflix Senior UI Designer (مثال)
//         "status": "Rejected",
//         "statusColor": Colors.red,
//       },
//     ];

//     return Column(
//       children: [
//         const SizedBox(height: 15),
//         _buildFilterChips(), // أزرار التصفية (All, Submitted, etc.)
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.all(20),
//             itemCount: appliedJobs.length,
//             itemBuilder: (context, index) {
//               final item = appliedJobs[index];
//               return _buildAppliedJobCard(item['job'], item['status'], item['statusColor']);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // أزرار التصفية العلوية
//   Widget _buildFilterChips() {
//     List<String> filters = ["All", "Submitted", "Interview", "Accepted", "Rejected"];
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: filters.length,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.only(right: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//               color: index == 0 ? Colors.white : Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade200),
//             ),
//             child: Center(
//               child: Text(filters[index], style: const TextStyle(fontSize: 13, color: Colors.black54)),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAppliedJobCard(Job job, String status, Color statusColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(job.companyLogo, width: 45, height: 45, errorBuilder: (c, e, s) => const Icon(Icons.business)),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                     Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.radio_button_checked, size: 18, color: statusColor),
//                   const SizedBox(width: 8),
//                   Text(status, style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.w500)),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
//                 child: Row(
//                   children: const [
//                     Text("View Details", style: TextStyle(color: Colors.grey, fontSize: 12)),
//                     Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // --- التبويب الثاني: الوظائف المحفوظة ---
//   Widget _buildSavedJobsTab() {
//     // نستخدم قائمة allJobs لمحاكاة الوظائف المحفوظة
//     final savedJobs = allJobs;

//     return ListView.builder(
//       padding: const EdgeInsets.all(20),
//       itemCount: savedJobs.length,
//       itemBuilder: (context, index) {
//         final job = savedJobs[index];
//         return _buildSavedJobCard(job);
//       },
//     );
//   }

//   Widget _buildSavedJobCard(Job job) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(job.companyLogo, width: 40, height: 40, errorBuilder: (c, e, s) => const Icon(Icons.business)),
//               ),
//               const Icon(Icons.bookmark, color: Color(0xFF334E58)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               _tag(job.jobType),
//               const SizedBox(width: 8),
//               _tag(job.experienceLevel),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
//                 child: const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 12)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _tag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
//       child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.blueGrey)),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// // استيراد الموديل والداتا الخاصة بك
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_details.dart';


// class TrackJobPage extends StatefulWidget {
//   const TrackJobPage({super.key});

//   @override
//   State<TrackJobPage> createState() => _TrackJobPageState();
// }

// class _TrackJobPageState extends State<TrackJobPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     // تعريف التبويبات
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: const Text("Tracking", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xFF334E58),
//           indicatorWeight: 3,
//           labelColor: const Color(0xFF334E58),
//           unselectedLabelColor: Colors.grey,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           tabs: const [
//             Tab(text: "Applied Job Details"),
//             Tab(text: "Save Job"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildAppliedJobsTab(),
//           _buildSavedJobsTab(),
//         ],
//       ),
//     );
//   }

//   // --- التبويب الأول: يعتمد كلياً على طول قائمة allJobs ---
//   Widget _buildAppliedJobsTab() {
//     // التحقق إذا كانت القائمة فارغة لعرض واجهة مناسبة
//     if (allJobs.isEmpty) {
//       return _buildEmptyState("No applications submitted yet.");
//     }

//     return Column(
//       children: [
//         const SizedBox(height: 15),
//         _buildFilterChips(), 
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             // هنا يكمن السر: عدد الكروت يساوي عدد العناصر في القائمة فعلياً
//             itemCount: allJobs.length, 
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) {
//               // الوصول للعنصر الحالي بناءً على اللفة (index)
//               final jobData = allJobs[index]; 
              
//               // توزيع حالات وهمية بناءً على الرقم الزوجي والفردي للتنويع البصري فقط
//               String status = (index % 3 == 0) ? "Application Submitted" : (index % 3 == 1 ? "Interview" : "Rejected");
//               Color statusColor = (index % 3 == 2) ? Colors.red : (index % 3 == 1 ? Colors.orange : Colors.blueGrey);
              
//               return _buildAppliedJobCard(jobData, status, statusColor);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // --- التبويب الثاني: يعتمد أيضاً على طول قائمة allJobs ---
//   Widget _buildSavedJobsTab() {
//     if (allJobs.isEmpty) {
//       return _buildEmptyState("You haven't saved any jobs yet.");
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(20),
//       itemCount: allJobs.length,
//       physics: const BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         final jobData = allJobs[index];
//         return _buildSavedJobCard(jobData);
//       },
//     );
//   }

//   // --- Widgets المساعدة لبناء الكروت ---

//   Widget _buildAppliedJobCard(Job job, String status, Color statusColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   job.companyLogo, 
//                   width: 45, height: 45, 
//                   errorBuilder: (c, e, s) => const Icon(Icons.business, color: Colors.grey)
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                     Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.radio_button_checked, size: 18, color: statusColor),
//                   const SizedBox(width: 8),
//                   Text(status, style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.w500)),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
//                 child: const Text("View Details >", style: TextStyle(color: Colors.grey, fontSize: 12)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSavedJobCard(Job job) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade100),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.network(job.companyLogo, width: 40, height: 40, errorBuilder: (c, e, s) => const Icon(Icons.business)),
//               const Icon(Icons.bookmark, color: Color(0xFF334E58)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text("${job.companyName} • ${job.location}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
//                 child: const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState(String message) {
//     return Center(child: Text(message, style: const TextStyle(color: Colors.grey)));
//   }

//   Widget _buildFilterChips() {
//     List<String> filters = ["All", "Submitted", "Interview", "Accepted", "Rejected"];
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: filters.length,
//         itemBuilder: (context, index) => Container(
//           margin: const EdgeInsets.only(right: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
//           child: Center(child: Text(filters[index], style: const TextStyle(fontSize: 12))),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/data/datasource/data_test.dart';
// استيراد الموديلات والبيانات المركزية
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/view/screen/home/job_details.dart';
import 'package:workscout/controller/job_controller.dart';

class TrackJobPage extends StatefulWidget {
  const TrackJobPage({super.key});

  @override
  State<TrackJobPage> createState() => _TrackJobPageState();
}

class _TrackJobPageState extends State<TrackJobPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Get.find<JobController>().fetchSavedJobs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Tracking", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF334E58),
          indicatorWeight: 3,
          labelColor: const Color(0xFF334E58),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: "Applied Job Details"),
            Tab(text: "Save Job"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppliedJobsTab(),
          _buildSavedJobsTab(),
        ],
      ),
    );
  }

  // --- التبويب الأول: يعتمد على قائمة التقديمات الحقيقية myApplications ---
  Widget _buildAppliedJobsTab() {
    if (myApplications.isEmpty) {
      return _buildEmptyState("No applications submitted yet.");
    }

    return Column(
      children: [
        const SizedBox(height: 15),
        _buildFilterChips(), 
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: myApplications.length, 
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final application = myApplications[index]; 
              return _buildAppliedJobCard(application);
            },
          ),
        ),
      ],
    );
  }

  // --- التبويب الثاني: يقـرأ من JobController.savedJobs التفاعلية ---
  Widget _buildSavedJobsTab() {
    final jobCtrl = Get.find<JobController>();

    return Obx(() {
      if (jobCtrl.savedJobs.isEmpty) {
        return _buildEmptyState("You haven't saved any jobs yet.");
      }

      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: jobCtrl.savedJobs.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildSavedJobCard(jobCtrl.savedJobs[index]);
        },
      );
    });
  }

  // --- كرت التقديمات المحدث ---
  Widget _buildAppliedJobCard(JobApplication app) {
    Color statusColor = _getStatusColor(app.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  app.job.companyLogo, 
                  width: 45, height: 45, 
                  errorBuilder: (c, e, s) => const Icon(Icons.business, color: Colors.grey)
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(app.job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(app.job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.radio_button_checked, size: 18, color: statusColor),
                  const SizedBox(width: 8),
                  Text(app.status, style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: app.job))),
                child: const Text("View Details >", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- كرت المحفوظات المحدث ---
  Widget _buildSavedJobCard(Job job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(job.companyLogo, width: 40, height: 40, errorBuilder: (c, e, s) => const Icon(Icons.business))
              ),
              IconButton(
                icon: const Icon(Icons.bookmark, color: Color(0xFF334E58)),
                onPressed: () async {
                  await Get.find<JobController>().toggleBookmark(job.id);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("${job.companyName} • ${job.location}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
                child: const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // دالة لتحديد لون الحالة برمجياً
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Interview': return Colors.orange;
      case 'Rejected': return Colors.red;
      case 'Accepted': return Colors.green;
      case 'Submitted': return Colors.blueGrey;
      default: return Colors.blueGrey;
    }
  }

  Widget _buildEmptyState(String message) {
    return Center(child: Text(message, style: const TextStyle(color: Colors.grey)));
  }

  Widget _buildFilterChips() {
    List<String> filters = ["All", "Submitted", "Interview", "Accepted", "Rejected"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
          child: Center(child: Text(filters[index], style: const TextStyle(fontSize: 12))),
        ),
      ),
    );
  }
}