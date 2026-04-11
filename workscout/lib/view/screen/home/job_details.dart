// import 'package:flutter/material.dart';
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_apply.dart';


// class JobDetailsPage extends StatelessWidget {
//   final Job job;

//   const JobDetailsPage({super.key, required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: [
//           IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.black), onPressed: () {}),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 // Header: Logo & Title
//                 Center(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 80, width: 80,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(job.companyLogo, errorBuilder: (c, e, s) => const Icon(Icons.business, size: 40)),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 16)),
//                       Text(job.jobTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 10),
//                       Text(job.location, style: const TextStyle(color: Colors.blueGrey)),
//                       const SizedBox(height: 5),
//                       Text(job.salary, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // Info Row: Experience, Type, Level
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _infoTile("Experience", "2 - 6 Years"),
//                     _infoTile("Job Type", job.jobType),
//                     _infoTile("Level", job.experienceLevel),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                 const SizedBox(height: 25),
//                 // Hiring Manager Card
//                 _buildManagerCard(),
//                 const SizedBox(height: 25),
//                 // Skills
//                 const Text("Must Have Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 Wrap(
//                   spacing: 8, runSpacing: 8,
//                   children: job.skills.map((skill) => _buildSkillChip(skill)).toList(),
//                 ),
//                 const SizedBox(height: 25),
//                 // Description & Responsibilities
//                 _buildSection("Job Description", job.description),
//                 _buildListSection("Responsibilities", job.responsibilities),
//                 _buildListSection("Requirements", job.requirements),
//                 _buildListSection("Benefits", job.benefits),
//                 const SizedBox(height: 100), // مساحة للزر في الأسفل
//               ],
//             ),
//           ),
//           // Bottom Action Bar
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
//                     child: const Icon(Icons.share_outlined),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF334E58),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplyJobPage(job: job,)));
//                       },
//                       child: const Text("Apply Now", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoTile(String label, String value) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         const SizedBox(height: 5),
//         Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//       ],
//     );
//   }

//   Widget _buildManagerCard() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: const Color(0xFFFFF9F2), borderRadius: BorderRadius.circular(15)),
//       child: Row(
//         children: [
//           const CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, color: Colors.white)),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text("This job post is managed by", style: TextStyle(fontSize: 12, color: Colors.grey)),
//                 Text("Nabilla Nares", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("Online 2 days ago", style: TextStyle(fontSize: 10, color: Colors.grey)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillChip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
//       child: Text(label, style: const TextStyle(fontSize: 12)),
//     );
//   }

//   Widget _buildSection(String title, String content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         Text(content, style: const TextStyle(color: Colors.black54, height: 1.5)),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildListSection(String title, List<String> items) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         ...items.map((item) => Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
//               Expanded(child: Text(item, style: const TextStyle(color: Colors.black54, height: 1.4))),
//             ],
//           ),
//         )).toList(),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:workscout/data/datasource/data_test.dart';
// استيراد الموديلات والداتا
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/view/screen/home/job_apply.dart';

class JobDetailsPage extends StatefulWidget {
  final Job job;

  const JobDetailsPage({super.key, required this.job});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // فحص ما إذا كانت الوظيفة محفوظة حالياً في قائمة المستخدم
    bool isSaved = currentUser.savedJobsIds.contains(widget.job.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Details", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          // زر الحفظ التفاعلي المربوط بالبيانات المركزية
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border, 
              color: isSaved ? const Color(0xFF334E58) : Colors.black
            ), 
            onPressed: () {
              setState(() {
                if (isSaved) {
                  currentUser.savedJobsIds.remove(widget.job.id);
                } else {
                  currentUser.savedJobsIds.add(widget.job.id);
                }
              });
              // تنبيه بسيط للمستخدم (اختياري)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isSaved ? "Removed from saved jobs" : "Job saved successfully"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header: Logo & Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 80, width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.job.companyLogo, 
                            errorBuilder: (c, e, s) => const Icon(Icons.business, size: 40)
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(widget.job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      Text(widget.job.jobTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(widget.job.location, style: const TextStyle(color: Colors.blueGrey)),
                      const SizedBox(height: 5),
                      Text(widget.job.salary, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Info Row: Experience, Type, Level
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoTile("Experience", widget.job.experienceLevel),
                    _infoTile("Job Type", widget.job.jobType),
                    _infoTile("Level", "Entry level"), // يمكنك جعلها ديناميكية لاحقاً
                  ],
                ),
                const SizedBox(height: 15),
                Text(widget.job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 25),
                // Hiring Manager Card
                _buildManagerCard(),
                const SizedBox(height: 25),
                // Skills
                const Text("Must Have Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: widget.job.skills.map((skill) => _buildSkillChip(skill)).toList(),
                ),
                const SizedBox(height: 25),
                // Description & Responsibilities
                _buildSection("Job Description", widget.job.description),
                _buildListSection("Responsibilities", widget.job.responsibilities),
                _buildListSection("Requirements", widget.job.requirements),
                _buildListSection("Benefits", widget.job.benefits),
                const SizedBox(height: 100), // مساحة للزر في الأسفل
              ],
            ),
          ),
          // Bottom Action Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.share_outlined),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF334E58),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyJobPage(job: widget.job)));
                      },
                      child: const Text("Apply Now", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets المساعدة ---
  Widget _infoTile(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildManagerCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFFFFF9F2), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, color: Colors.white)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("This job post is managed by", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text("Nabilla Nares", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Online 2 days ago", style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(content, style: const TextStyle(color: Colors.black54, height: 1.5)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: Text(item, style: const TextStyle(color: Colors.black54, height: 1.4))),
            ],
          ),
        )).toList(),
        const SizedBox(height: 20),
      ],
    );
  }
}