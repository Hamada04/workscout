// // home.dart
// import 'package:flutter/material.dart';
// import 'package:workscout/data/model/job_model.dart';
// // استيراد الموديل

// class JobPage extends StatefulWidget {
//   @override
//   _JobPageState createState() => _JobPageState();
// }

// class _JobPageState extends State<JobPage> {
//   // ستخزن هذه المتغيرات الوظائف من data.dart
//   late List<Job> companiesData = [];
//   late List<Job> recommendationJobs = [];

//   @override
//   void initState() {
//     super.initState();
//     // تعليق على الكود الذي يستدعي الـ API لجلب البيانات
//     fetchJobs(); // قم بتفعيل هذه الدالة بعد أن تكون الـ API جاهزة
//   }

//   // تعليق على جلب البيانات من الـ API
//   Future<void> fetchJobs() async {
//     // هذا هو المكان الذي ستقوم فيه بجلب البيانات من API عندما يكون جاهزًا.
//     // في الوقت الحالي، سيتم تعليق الكود لأنه لا يوجد API مفعّل بعد
//     /*
//     final response = await http.get(Uri.parse('http://your-api-endpoint/getJobs'));

//     if (response.statusCode == 200) {
//       List jsonData = json.decode(response.body);

//       setState(() {
//         // تخزين البيانات المستلمة من الـ API في المتغيرات
//         companiesData = jsonData.map((item) => Job.fromJson(item)).toList();
//         recommendationJobs = jsonData.where((item) => item['isRecommendation'] == true)
//                                       .map((item) => Job.fromJson(item))
//                                       .toList();
//       });
//     } else {
//       throw Exception('Failed to load jobs');
//     }
//     */

//     // في الوقت الحالي، نقوم بتخزين البيانات الثابتة
//     setState(() {
//       companiesData = companiesData;
//       recommendationJobs = recommendationJobs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Job Listings')),
//       body: ListView(
//         children: companiesData.map((job) {
//           return _jobCard(job);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _jobCard(Job job) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: Icon(Icons.business),
//         title: Text(job.companyName),
//         subtitle: Text(job.jobTitle),
//         trailing: Text(job.postedDate),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:workscout/data/model/job_model.dart';
//  // استيراد الموديل



// class JobPage extends StatefulWidget {
//   @override
//   _JobPageState createState() => _JobPageState();
// }

// class _JobPageState extends State<JobPage> {
//   late List<Job> companiesData = [];
//   late List<Job> recommendationJobs = [];

//   @override
//   void initState() {
//     super.initState();
//     // تعليق على الكود الذي يستدعي الـ API لجلب البيانات
//     fetchJobs(); // قم بتفعيل هذه الدالة بعد أن تكون الـ API جاهزة
//   }

//   // تعليق على جلب البيانات من الـ API
//   Future<void> fetchJobs() async {
//     // هذا هو المكان الذي ستقوم فيه بجلب البيانات من API عندما يكون جاهزًا.
//     // في الوقت الحالي، سيتم تعليق الكود لأنه لا يوجد API مفعّل بعد
//     /*
//     final response = await http.get(Uri.parse('http://your-api-endpoint/getJobs'));

//     if (response.statusCode == 200) {
//       List jsonData = json.decode(response.body);

//       setState(() {
//         // تخزين البيانات المستلمة من الـ API في المتغيرات
//         companiesData = jsonData.map((item) => Job.fromJson(item)).toList();
//         recommendationJobs = jsonData.where((item) => item['isRecommendation'] == true)
//                                       .map((item) => Job.fromJson(item))
//                                       .toList();
//       });
//     } else {
//       throw Exception('Failed to load jobs');
//     }
//     */

//     // في الوقت الحالي، نقوم بتخزين البيانات الثابتة
//     setState(() {
//       companiesData = companiesData;
//       recommendationJobs = recommendationJobs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage('assets/profile.jpg'), // صورة المستخدم
//             ),
//             SizedBox(width: 10),
//             Text('Nabilla - UI/UX Designer'),
//           ],
//         ),
//         actions: [
//           IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // قسم البحث
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search Job',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),

//             // قسم "10 ways to increase your chances of getting hired"
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 height: 150,
//                 color: Colors.blue[50],
//                 child: Center(child: Text('10 ways to increase your chances of getting hired')),
//               ),
//             ),

//             // قسم الوظائف المقترحة
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Curated Jobs For You', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             _jobCard('Invision', 'UI Designer'),
//             _jobCard('Telegram', 'Digital Marketing'),

//             // قسم التخصصات
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Specialization', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             _specializationCard('Finance'),
//             _specializationCard('Technology'),
//             _specializationCard('Marketing'),

//             // قسم الوظائف الموصى بها
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Recommendation', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             _jobCard('Netflix', 'UI Designer'),
//             _jobCard('Autodesk', 'Human Resources'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _jobCard(String company, String title) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: Icon(Icons.business),
//         title: Text(company),
//         subtitle: Text(title),
//         trailing: Text('3 days ago'),
//       ),
//     );
//   }

//   Widget _specializationCard(String specialization) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         title: Text(specialization),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// // تأكد من تعديل المسارات حسب مشروعك

// import 'package:workscout/data/datasource/data_test.dart'; 
// import 'package:workscout/data/model/job_model.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             _buildSearchBar(),
//             const SizedBox(height: 15),
//             _buildLocationFilter(),
//             const SizedBox(height: 20),
//             _buildPromoBanner(),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Curated Jobs For You"),
//             _buildCategories(),
//             const SizedBox(height: 15),
//             _buildCuratedJobsList(),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Specialization"),
//             _buildSpecializationGrid(),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Recommendation"),
//             _buildRecommendationList(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- Header & App Bar ---
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: const Padding(
//         padding: EdgeInsets.only(left: 20),
//         child: CircleAvatar(
//           backgroundImage: NetworkImage('https://via.placeholder.com/150'), // استبدلها بصورة Nabilla
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Nabilla", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
//           Row(
//             children: const [
//               Text("UI/UX Designer", style: TextStyle(color: Colors.grey, fontSize: 14)),
//               Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications_none_outlined, color: Colors.black, size: 28),
//           onPressed: () {},
//         ),
//         const SizedBox(width: 10),
//       ],
//     );
//   }

//   // --- Search Bar ---
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 15),
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationFilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: const [
//             Text("Most Relevant", style: TextStyle(fontWeight: FontWeight.w500)),
//             Icon(Icons.keyboard_arrow_down),
//           ],
//         ),
//         Row(
//           children: const [
//             Icon(Icons.location_on, color: Colors.blueGrey, size: 18),
//             Text(" Jakarta, Indonesia", style: TextStyle(decoration: TextDecoration.underline)),
//           ],
//         ),
//       ],
//     );
//   }

//   // --- Promo Banner ---
//   Widget _buildPromoBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [Color(0xFF438883), Color(0xFF6FB1AC)]),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "10 ways to increase your\nchances of getting hired",
//             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF3E5A68),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             ),
//             child: const Text("Read a blog", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Categories ---
//   Widget _buildCategories() {
//     List<String> cats = ["Design", "Business", "Marketing", "Technology"];
//     return SizedBox(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: cats.length,
//         itemBuilder: (context, index) {
//           bool isSelected = index == 0;
//           return Container(
//             margin: const EdgeInsets.only(right: 10, top: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFF3E5A68) : Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
//             ),
//             child: Center(
//               child: Text(
//                 cats[index],
//                 style: TextStyle(color: isSelected ? Colors.white : Colors.black),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- Jobs List (Horizontal) ---
//   Widget _buildCuratedJobsList() {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: companiesData.length,
//         itemBuilder: (context, index) {
//           return JobCard(job: companiesData[index], isHorizontal: true);
//         },
//       ),
//     );
//   }

//   // --- Specialization Grid ---
//   Widget _buildSpecializationGrid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _specializationItem("Finance", Icons.trending_up, Colors.orange.shade50),
//         _specializationItem("Technology", Icons.code, Colors.purple.shade50),
//         _specializationItem("Marketing", Icons.campaign, Colors.red.shade50),
//       ],
//     );
//   }

//   Widget _specializationItem(String title, IconData icon, Color color) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           Icon(icon, color: Colors.blueGrey),
//         ],
//       ),
//     );
//   }

//   // --- Recommendation List (Vertical) ---
//   Widget _buildRecommendationList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: recommendationJobs.length,
//       itemBuilder: (context, index) {
//         return JobCard(job: recommendationJobs[index], isHorizontal: false);
//       },
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: const Color(0xFF3E5A68),
//       unselectedItemColor: Colors.grey,
//       currentIndex: 0,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
//       ],
//     );
//   }
// }

// // --- Reusable Job Card Widget ---
// class JobCard extends StatelessWidget {
//   final Job job;
//   final bool isHorizontal;

//   const JobCard({super.key, required this.job, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 15 : 0, bottom: isHorizontal ? 0 : 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
//                 child: const Icon(Icons.business, size: 30, color: Colors.blueGrey), // استبدله بلوجو الشركة
//               ),
//               const Icon(Icons.bookmark_border, color: Colors.blueGrey),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 13)),
//           Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text("${job.location} - Onsite", style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               _tag(job.jobType),
//               const SizedBox(width: 5),
//               _tag(job.contractType),
//               const SizedBox(width: 5),
//               _tag(job.experienceLevel),
//             ],
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//               const Text("View Details", style: TextStyle(color: Color(0xFF3E5A68), fontWeight: FontWeight.bold, fontSize: 12)),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _tag(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// // تأكد أن هذا المسار يطابق اسم مشروعك ومكان ملف الداتا
// // import 'package:your_project_name/data.dart'; 
// // import 'package:your_project_name/model.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB), // لون خلفية مريح مثل التصميم
//       appBar: _buildAppBar(), // تم تصحيح التسمية هنا
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 15),
//               _buildSearchBar(),
//               const SizedBox(height: 15),
//               _buildLocationFilter(),
//               const SizedBox(height: 20),
//               _buildPromoBanner(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Curated Jobs For You"),
//               const SizedBox(height: 10),
//               _buildCategories(),
//               const SizedBox(height: 15),
//               _buildCuratedJobsList(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Specialization"),
//               const SizedBox(height: 15),
//               _buildSpecializationGrid(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Recommendation"),
//               const SizedBox(height: 15),
//               _buildRecommendationList(),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Header ---
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       toolbarHeight: 70,
//       leadingWidth: 70,
//       leading: const Padding(
//         padding: EdgeInsets.only(left: 20),
//         child: CircleAvatar(
//           backgroundColor: Color(0xFFE0E0FF),
//           child: Icon(Icons.person, color: Colors.blueGrey), 
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text("Nabilla", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//           Row(
//             children: const [
//               Text("UI/UX Designer", style: TextStyle(color: Colors.grey, fontSize: 12)),
//               Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         Container(
//           margin: const EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade200),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.black),
//             onPressed: () {},
//           ),
//         ),
//       ],
//     );
//   }

//   // --- Search Bar ---
//   Widget _buildSearchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           hintStyle: TextStyle(color: Colors.grey),
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationFilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: const [
//             Text("Most Relevant", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//             Icon(Icons.keyboard_arrow_down, size: 20),
//           ],
//         ),
//         Row(
//           children: const [
//             Icon(Icons.location_on_outlined, color: Colors.blueGrey, size: 18),
//             Text(" Jakarta, Indonesia", style: TextStyle(fontSize: 13, decoration: TextDecoration.underline, color: Colors.blueGrey)),
//           ],
//         ),
//       ],
//     );
//   }

//   // --- Promo Banner ---
//   Widget _buildPromoBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF427A7D), Color(0xFF6FB1AC)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "10 ways to increase your\nchances of getting hired",
//             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF334E58),
//               elevation: 0,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//             child: const Text("Read a blog", style: TextStyle(color: Colors.white, fontSize: 12)),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Categories ---
//   Widget _buildCategories() {
//     List<String> labels = ["Design", "Business", "Marketing", "Technology"];
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: labels.length,
//         itemBuilder: (context, index) {
//           bool isSelected = index == 0;
//           return Container(
//             margin: const EdgeInsets.only(right: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFF334E58) : Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
//             ),
//             child: Center(
//               child: Text(
//                 labels[index],
//                 style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: FontWeight.w500),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- Horizontal List (Curated Jobs) ---
//   Widget _buildCuratedJobsList() {
//     // استخدمنا ListView.builder مع shrinkWrap
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 2, // يمكنك استبداله بـ companiesData.length
//         itemBuilder: (context, index) {
//           return const JobCardHorizontal(); 
//         },
//       ),
//     );
//   }

//   // --- Specialization ---
//   Widget _buildSpecializationGrid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _specItem("Finance", Icons.trending_up, const Color(0xFFFFF7ED)),
//         _specItem("Technology", Icons.code, const Color(0xFFF5F3FF)),
//         _specItem("Marketing", Icons.campaign, const Color(0xFFFEF2F2)),
//       ],
//     );
//   }

//   Widget _specItem(String text, IconData icon, Color bg) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         children: [
//           Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 10),
//           Icon(icon, color: Colors.black54),
//         ],
//       ),
//     );
//   }

//   // --- Vertical List (Recommendation) ---
//   Widget _buildRecommendationList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 3, // استبدله بـ recommendationJobs.length
//       itemBuilder: (context, index) {
//         return const JobCardVertical();
//       },
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)));
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       selectedItemColor: const Color(0xFF334E58),
//       unselectedItemColor: Colors.grey,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
//       ],
//     );
//   }
// }

// // --- Card Widgets (Placeholder versions to ensure they show up) ---

// class JobCardHorizontal extends StatelessWidget {
//   const JobCardHorizontal({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 260,
//       margin: const EdgeInsets.only(right: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(Icons.abc_outlined, color: Colors.red, size: 30), // لوجو تجريبي
//           const SizedBox(height: 10),
//           const Text("Invision", style: TextStyle(color: Colors.grey, fontSize: 12)),
//           const Text("UI Designer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           const Text("Jakarta, Indonesia - Onsite", style: TextStyle(color: Colors.grey, fontSize: 11)),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text("3 days ago", style: TextStyle(color: Colors.grey, fontSize: 11)),
//               Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class JobCardVertical extends StatelessWidget {
//   const JobCardVertical({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.grey.shade100),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50, height: 50,
//             decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
//             child: const Icon(Icons.business, color: Colors.blueGrey),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text("Netflix", style: TextStyle(color: Colors.grey, fontSize: 11)),
//                 Text("UI Designer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                 Text("Jakarta, Indonesia", style: TextStyle(color: Colors.grey, fontSize: 11)),
//               ],
//             ),
//           ),
//           const Icon(Icons.bookmark_border, color: Colors.grey),
//         ],
//       ),
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_details.dart';
// // استيراد الملفات الخاصة بك


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // سنقوم بتقسيم البيانات هنا (يمكنك تصفيتها حسب الحاجة)
//     final curatedJobs = allJobs.where((j) => j.experienceLevel == 'Entry level').toList();
//     final recommendations = allJobs;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB),
//       appBar: _buildAppBar(),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 15),
//               _buildSearchBar(),
//               const SizedBox(height: 15),
//               _buildLocationFilter(),
//               const SizedBox(height: 20),
//               _buildPromoBanner(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Curated Jobs For You"),
//               const SizedBox(height: 10),
//               _buildCategories(),
//               const SizedBox(height: 15),
//               // قائمة الوظائف المختارة (أفقية)
//               _buildHorizontalJobList(curatedJobs),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Specialization"),
//               const SizedBox(height: 15),
//               _buildSpecializationGrid(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Recommendation"),
//               const SizedBox(height: 15),
//               // قائمة التوصيات (رأسية)
//               _buildVerticalJobList(recommendations),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Header ---
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       toolbarHeight: 70,
//       leading: const Padding(
//         padding: EdgeInsets.only(left: 20),
//         child: CircleAvatar(
//           backgroundImage: NetworkImage('https://via.placeholder.com/150'), 
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Nabilla", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//           Row(
//             children: const [
//               Text("UI/UX Designer", style: TextStyle(color: Colors.grey, fontSize: 12)),
//               Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
//           onPressed: () {},
//         ),
//         const SizedBox(width: 15),
//       ],
//     );
//   }

//   // --- Widgets البناء المساعدة ---

//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationFilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(children: const [Text("Most Relevant", style: TextStyle(fontWeight: FontWeight.w500)), Icon(Icons.keyboard_arrow_down)]),
//         const Text("Jakarta, Indonesia", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueGrey)),
//       ],
//     );
//   }

//   Widget _buildPromoBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [Color(0xFF438883), Color(0xFF6FB1AC)]),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("10 ways to increase your\nchances of getting hired", 
//             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)),
//             child: const Text("Read a blog", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- التعامل مع القوائم الديناميكية ---

//   Widget _buildHorizontalJobList(List<Job> jobs) {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: jobs.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobs[index]))),
//             child: JobCard(job: jobs[index], isHorizontal: true),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildVerticalJobList(List<Job> jobs) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: jobs.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobs[index]))),
//           child: JobCard(job: jobs[index], isHorizontal: false),
//         );
//       },
//     );
//   }

//   // (باقي الـ Widgets مثل Categories و Specialization تبقى كما هي في الكود السابق)
//   Widget _buildCategories() {
//      return SizedBox(
//       height: 40,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: ["Design", "Business", "Marketing", "Technology"].map((cat) => Container(
//           margin: const EdgeInsets.only(right: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           decoration: BoxDecoration(
//             color: cat == "Design" ? const Color(0xFF334E58) : Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Text(cat, style: TextStyle(color: cat == "Design" ? Colors.white : Colors.black54)),
//         )).toList(),
//       ),
//     );
//   }

//   Widget _buildSpecializationGrid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _specBox("Finance", Icons.trending_up, const Color(0xFFFFF7ED)),
//         _specBox("Technology", Icons.code, const Color(0xFFF5F3FF)),
//         _specBox("Marketing", Icons.campaign, const Color(0xFFFEF2F2)),
//       ],
//     );
//   }

//   Widget _specBox(String t, IconData i, Color c) {
//     return Container(
//       width: 100, padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(15)),
//       child: Column(children: [Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Icon(i)]),
//     );
//   }

//   Widget _buildSectionHeader(String title) => Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: const Color(0xFF334E58),
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
//       ],
//     );
//   }
// }

// // --- Card Widget الموحد ---
// class JobCard extends StatelessWidget {
//   final Job job;
//   final bool isHorizontal;
//   const JobCard({super.key, required this.job, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 15 : 0, bottom: isHorizontal ? 0 : 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.network(job.companyLogo, width: 40, height: 40, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//               const Icon(Icons.bookmark_border, color: Colors.grey),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               _tag(job.jobType),
//               const SizedBox(width: 5),
//               _tag(job.experienceLevel),
//             ],
//           ),
//           if (isHorizontal) const Spacer(),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _tag(String txt) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(5)),
//     child: Text(txt, style: const TextStyle(fontSize: 10, color: Colors.blueGrey)),
//   );
// }
// import 'package:flutter/material.dart';
// // استيراد الموديل والداتا الخاصة بك
// import 'package:workscout/data/model/job_model.dart'; //
// import 'package:workscout/data/data.dart'; // القوائم: companiesData و recommendationJobs
// import 'job_details_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB),
//       appBar: _buildAppBar(),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               _buildSearchBar(),
//               const SizedBox(height: 15),
//               _buildLocationFilter(),
//               const SizedBox(height: 20),
//               _buildPromoBanner(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Curated Jobs For You"),
//               const SizedBox(height: 10),
//               _buildCategories(),
//               const SizedBox(height: 15),
              
//               // --- عرض البيانات من قائمة companiesData ---
//               _buildHorizontalList(companiesData), //
              
//               const SizedBox(height: 25),
//               _buildSectionHeader("Specialization"),
//               const SizedBox(height: 15),
//               _buildSpecializationGrid(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Recommendation"),
//               const SizedBox(height: 15),
              
//               // --- عرض البيانات من قائمة recommendationJobs ---
//               _buildVerticalList(recommendationJobs), //
              
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // دالة بناء القائمة الأفقية بناءً على البيانات المستلمة
//   Widget _buildHorizontalList(List<Job> jobs) {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: jobs.length, // عدد العناصر يعتمد على القائمة
//         itemBuilder: (context, index) {
//           final jobItem = jobs[index];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context, 
//               MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem))
//             ),
//             child: JobCard(job: jobItem, isHorizontal: true),
//           );
//         },
//       ),
//     );
//   }

//   // دالة بناء القائمة الرأسية بناءً على البيانات المستلمة
//   Widget _buildVerticalList(List<Job> jobs) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: jobs.length, // عدد العناصر ديناميكي
//       itemBuilder: (context, index) {
//         final jobItem = jobs[index];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context, 
//             MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem))
//           ),
//           child: JobCard(job: jobItem, isHorizontal: false),
//         );
//       },
//     );
//   }
//     Widget _buildCategories() {
//      return SizedBox(
//       height: 40,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: ["Design", "Business", "Marketing", "Technology"].map((cat) => Container(
//           margin: const EdgeInsets.only(right: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           decoration: BoxDecoration(
//             color: cat == "Design" ? const Color(0xFF334E58) : Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Text(cat, style: TextStyle(color: cat == "Design" ? Colors.white : Colors.black54)),
//         )).toList(),
//       ),
//     );
//   }

//   Widget _buildSpecializationGrid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _specBox("Finance", Icons.trending_up, const Color(0xFFFFF7ED)),
//         _specBox("Technology", Icons.code, const Color(0xFFF5F3FF)),
//         _specBox("Marketing", Icons.campaign, const Color(0xFFFEF2F2)),
//       ],
//     );
//   }

//   Widget _specBox(String t, IconData i, Color c) {
//     return Container(
//       width: 100, padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(15)),
//       child: Column(children: [Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Icon(i)]),
//     );
//   }

//   Widget _buildSectionHeader(String title) => Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: const Color(0xFF334E58),
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
//       ],
//     );
//   }
// }

// // --- Card Widget الموحد ---
// class JobCard extends StatelessWidget {
//   final Job job;
//   final bool isHorizontal;
//   const JobCard({super.key, required this.job, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 15 : 0, bottom: isHorizontal ? 0 : 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.network(job.companyLogo, width: 40, height: 40, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//               const Icon(Icons.bookmark_border, color: Colors.grey),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               _tag(job.jobType),
//               const SizedBox(width: 5),
//               _tag(job.experienceLevel),
//             ],
//           ),
//           if (isHorizontal) const Spacer(),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _tag(String txt) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(5)),
//     child: Text(txt, style: const TextStyle(fontSize: 10, color: Colors.blueGrey)),
//   );

//   // ... (بقية الـ Widgets المساعدة مثل SearchBar و AppBar تبقى كما هي)
// }
// import 'package:flutter/material.dart';
// // تأكد من صحة هذه المسارات حسب ترتيب ملفاتك
// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_details.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB),
//       appBar: _buildAppBar(),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               _buildSearchBar(),
//               const SizedBox(height: 15),
//               _buildLocationFilter(),
//               const SizedBox(height: 20),
//               _buildPromoBanner(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Curated Jobs For You"),
//               const SizedBox(height: 10),
//               _buildCategories(),
//               const SizedBox(height: 15),
              
//               // عرض البيانات من قائمة companiesData بشكل أفقي
//               _buildHorizontalList(companiesData),
              
//               const SizedBox(height: 25),
//               _buildSectionHeader("Specialization"),
//               const SizedBox(height: 15),
//               _buildSpecializationGrid(),
//               const SizedBox(height: 25),
//               _buildSectionHeader("Recommendation"),
//               const SizedBox(height: 15),
              
//               // عرض البيانات من قائمة recommendationJobs بشكل رأسي
//               _buildVerticalList(recommendationJobs),
              
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Header / AppBar ---
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       toolbarHeight: 70,
//       leading: const Padding(
//         padding: EdgeInsets.only(left: 20),
//         child: CircleAvatar(
//           backgroundImage: NetworkImage('https://via.placeholder.com/150'), // صورة Nabilla
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Nabilla", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//           Row(
//             children: const [
//               Text("UI/UX Designer", style: TextStyle(color: Colors.grey, fontSize: 12)),
//               Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
//           onPressed: () {},
//         ),
//         const SizedBox(width: 15),
//       ],
//     );
//   }

//   // --- Search Bar ---
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 15),
//         ),
//       ),
//     );
//   }

//   // --- Filter Row ---
//   Widget _buildLocationFilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: const [
//             Text("Most Relevant", style: TextStyle(fontWeight: FontWeight.w500)),
//             Icon(Icons.keyboard_arrow_down),
//           ],
//         ),
//         Row(
//           children: const [
//             Icon(Icons.location_on_outlined, size: 18, color: Colors.blueGrey),
//             Text(" Jakarta, Indonesia", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueGrey)),
//           ],
//         ),
//       ],
//     );
//   }

//   // --- Promo Banner ---
//   Widget _buildPromoBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [Color(0xFF438883), Color(0xFF6FB1AC)]),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "10 ways to increase your\nchances of getting hired",
//             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF334E58),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//             child: const Text("Read a blog", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Categories ---
//   Widget _buildCategories() {
//     List<String> categories = ["Design", "Business", "Marketing", "Technology"];
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           bool isSelected = index == 0;
//           return Container(
//             margin: const EdgeInsets.only(right: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFF334E58) : Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
//             ),
//             child: Center(
//               child: Text(
//                 categories[index],
//                 style: TextStyle(color: isSelected ? Colors.white : Colors.black54),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- Horizontal List Builder ---
//   Widget _buildHorizontalList(List<Job> jobs) {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: jobs.length,
//         itemBuilder: (context, index) {
//           final jobItem = jobs[index];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem)),
//             ),
//             child: JobCard(job: jobItem, isHorizontal: true),
//           );
//         },
//       ),
//     );
//   }

//   // --- Specialization Grid ---
//   Widget _buildSpecializationGrid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _specItem("Finance", Icons.trending_up, const Color(0xFFFFF7ED)),
//         _specItem("Technology", Icons.code, const Color(0xFFF5F3FF)),
//         _specItem("Marketing", Icons.campaign, const Color(0xFFFEF2F2)),
//       ],
//     );
//   }

//   Widget _specItem(String title, IconData icon, Color color) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           Icon(icon, color: Colors.black54),
//         ],
//       ),
//     );
//   }

//   // --- Vertical List Builder ---
//   Widget _buildVerticalList(List<Job> jobs) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: jobs.length,
//       itemBuilder: (context, index) {
//         final jobItem = jobs[index];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem)),
//           ),
//           child: JobCard(job: jobItem, isHorizontal: false),
//         );
//       },
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: const Color(0xFF334E58),
//       unselectedItemColor: Colors.grey,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
//       ],
//     );
//   }
// }

// // --- Reusable Job Card (يدعم الشكل الأفقي والرأسي) ---
// class JobCard extends StatelessWidget {
//   final Job job;
//   final bool isHorizontal;
//   const JobCard({super.key, required this.job, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 15 : 0, bottom: isHorizontal ? 0 : 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: isHorizontal 
//       ? _buildHorizontalCardContent() 
//       : _buildVerticalCardContent(),
//     );
//   }

//   Widget _buildHorizontalCardContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Icon(Icons.business, size: 40, color: Color(0xFF334E58)), // شعار افتراضي
//             const Icon(Icons.bookmark_border, color: Colors.grey),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Text("${job.location} - Onsite", style: const TextStyle(color: Colors.grey, fontSize: 11)),
//         const Spacer(),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _buildVerticalCardContent() {
//     return Row(
//       children: [
//         Container(
//           width: 50, height: 50,
//           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
//           child: const Icon(Icons.business, color: Color(0xFF334E58)),
//         ),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//               Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             ],
//           ),
//         ),
//         const Icon(Icons.bookmark_border, color: Colors.grey),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/controller/job_controller.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/view/screen/home/job_details.dart';
import 'package:workscout/view/screen/home/notifications_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // التصنيف المختار حالياً (افتراضياً Design)
  String selectedCategory = "Design";

  // قائمة التصنيفات الموجودة في الواجهة
  final List<String> categories = ["Design", "Business", "Marketing", "Technology"];

  @override
  Widget build(BuildContext context) {
    final jobCtrl = Get.find<JobController>();

    List<Job> filteredCuratedJobs = jobCtrl.jobs
        .where((job) => job.category.toLowerCase() == selectedCategory.toLowerCase())
        .toList();

    List<Job> recommendationJobs = jobCtrl.jobs;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: _buildAppBar(),
      // bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => jobCtrl.fetchJobs(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 15),
                _buildLocationFilter(),
                const SizedBox(height: 20),
                _buildPromoBanner(),
                const SizedBox(height: 25),
                _buildSectionHeader("Curated Jobs For You"),
                const SizedBox(height: 10),
                
                // قسم التصنيفات مع ميزة الضغط والفلترة
                _buildCategoriesList(),
                
                const SizedBox(height: 15),
                
                // القائمة الأفقية المفلترة
                filteredCuratedJobs.isEmpty 
                  ? const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No jobs in this category")))
                  : _buildHorizontalList(filteredCuratedJobs),
                
                const SizedBox(height: 25),
                _buildSectionHeader("Specialization"),
                const SizedBox(height: 15),
                _buildSpecializationGrid(),
                const SizedBox(height: 25),
                 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("Recommendation", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed("/GeminiRecommendationPage"),
                        child: SvgPicture.asset(
                          'assets/images/google-gemini.svg',
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                
                // القائمة الرأسية الشاملة
                _buildVerticalList(recommendationJobs),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widgets المساعدة ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: CircleAvatar(
          backgroundColor: Color(0xFFE0E0FF),
          child: Icon(Icons.person, color: Colors.blueGrey), 
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Get.find<AuthController>().currentUser.value?.name ?? '', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: const [
              Text("UI/UX Designer", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsPage()));
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search Job",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildLocationFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: const [Text("Most Relevant", style: TextStyle(fontWeight: FontWeight.w500)), Icon(Icons.keyboard_arrow_down)]),
        const Text("Amman, Jordan", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueGrey)),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF438883), Color(0xFF6FB1AC)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("10 ways to increase your\nchances of getting hired", 
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: const Text("Read a blog", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // بناء قائمة التصنيفات مع التفاعل
  Widget _buildCategoriesList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categories[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF334E58) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalList(List<Job> jobs) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final jobItem = jobs[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem))),
            child: JobCard(job: jobItem, isHorizontal: true),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList(List<Job> jobs) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final jobItem = jobs[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsPage(job: jobItem))),
          child: JobCard(job: jobItem, isHorizontal: false),
        );
      },
    );
  }

  Widget _buildSpecializationGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _specItem("Finance", Icons.trending_up, const Color(0xFFFFF7ED)),
        _specItem("Technology", Icons.code, const Color(0xFFF5F3FF)),
        _specItem("Marketing", Icons.campaign, const Color(0xFFFEF2F2)),
      ],
    );
  }

  Widget _specItem(String title, IconData icon, Color color) {
    return Container(
      width: 100, padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(children: [Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Icon(icon)]),
    );
  }

  Widget _buildSectionHeader(String title) => Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  // Widget _buildBottomNav() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: const Color(0xFF334E58),
  //     unselectedItemColor: Colors.grey,
  //     showSelectedLabels: false,
  //     showUnselectedLabels: false,
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "",),
  //       BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
  //       BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
  //       BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
  //     ],
  //   );
  // }
}

// --- Card Widget الموحد ---
// class JobCard extends StatelessWidget {
//   final Job job;
//   final bool isHorizontal;
//   const JobCard({super.key, required this.job, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 15 : 0, bottom: isHorizontal ? 0 : 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//       ),
//       child: isHorizontal 
//         ? _buildHorizontalContent() 
//         : _buildVerticalContent(),
//     );
//   }

//   Widget _buildHorizontalContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               height: 40, width: 40,
//               decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
//               child: Image.network(job.companyLogo, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//             ),
//             const Icon(Icons.bookmark_border, color: Colors.grey),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//         const Spacer(),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
//           ],
//         )
//       ],
//     );
//   }
  

//   Widget _buildVerticalContent() {

//     return Row(
//       children: [
//         Container(
//           width: 50, height: 50,
//           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
//           child: Image.network(job.companyLogo, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//         ),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//               Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//               Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             ],
//           ),
//         ),
//         const Icon(Icons.bookmark_border, color: Colors.grey),
//       ],
//     );
//   }
// }

class JobCard extends StatefulWidget {
  final Job job;
  final bool isHorizontal;
  const JobCard({super.key, required this.job, required this.isHorizontal});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final savedIds = authCtrl.currentUser.value?.savedJobsIds ?? [];
    final isSaved = savedIds.contains(widget.job.id);

    return Container(
      width: widget.isHorizontal ? 260 : double.infinity,
      margin: EdgeInsets.only(right: widget.isHorizontal ? 15 : 0, bottom: widget.isHorizontal ? 0 : 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.job.companyLogo, width: 40, height: 40, errorBuilder: (c, e, s) => const Icon(Icons.business)),
              ),
              // الزر التفاعلي للحفظ
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? const Color(0xFF334E58) : Colors.grey,
                ),
                onPressed: () async {
                  await Get.find<JobController>().toggleBookmark(widget.job.id);
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(widget.job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(widget.job.location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          if (widget.isHorizontal) const Spacer(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }
}