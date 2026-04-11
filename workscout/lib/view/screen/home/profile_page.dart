// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB),
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildProfileHeader(),
//             const SizedBox(height: 30),
//             _buildStatsSection(),
//             const SizedBox(height: 30),
//             _buildSectionHeader("Experience", () => _showAddExperience(context)),
//             _buildExperienceItem("UI/UX Designer", "Netflix", "California, US", "Dec 23 - Feb 24", "https://logo.clearbit.com/netflix.com"),
//             _buildExperienceItem("Junior UX Designer", "Qiwi", "California, US", "Aug 22 - Dec 23", "https://logo.clearbit.com/qiwi.com"),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Education", () => _showAddEducation(context)),
//             _buildEducationItem("Computer Science", "Indonesia University", "Bachelor (4.0)", "2016 - 2020"),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Skill", () => _showAddSkill(context)),
//             _buildSkillsWrap(["Figma", "Photoshop", "User Interviews", "User Research", "Usability Testing", "Interaction Design"]),
//             const SizedBox(height: 25),
//             _buildSectionHeader("Language", () => _showAddLanguage(context)),
//             _buildSkillsWrap(["English", "Mandarin", "Indonesia"]),
//             const SizedBox(height: 25),
//             _buildCVSection(context),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- AppBar ---
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//       centerTitle: true,
//       actions: [
//         IconButton(icon: const Icon(Icons.settings_outlined, color: Colors.black), onPressed: () {}),
//         const SizedBox(width: 10),
//       ],
//     );
//   }

//   // --- Profile Info ---
//   Widget _buildProfileHeader() {
//     return Column(
//       children: [
//         const CircleAvatar(
//           radius: 50,
//           backgroundImage: NetworkImage('https://via.placeholder.com/150'), // استبدلها بصورة Nabilla
//         ),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text("Nabilla", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(width: 5),
//             Icon(Icons.edit_outlined, size: 18, color: Colors.blueGrey),
//           ],
//         ),
//         const Text("Indonesia", style: TextStyle(color: Colors.grey)),
//       ],
//     );
//   }

//   // --- Stats Section ---
//   Widget _buildStatsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _statColumn("Applied", "12 Jobs"),
//         _buildDivider(),
//         _statColumn("Reviewed", "8 Jobs"),
//         _buildDivider(),
//         _statColumn("Interview", "3 Jobs"),
//       ],
//     );
//   }

//   Widget _statColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         const SizedBox(height: 5),
//         Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildDivider() => Container(height: 30, width: 1, color: Colors.grey.shade300);

//   // --- Experience & Education Items ---
//   Widget _buildExperienceItem(String title, String company, String loc, String date, String logo) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Row(
//         children: [
//           Container(
//             width: 50, height: 50,
//             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//             child: Image.network(logo, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text("$company • $loc", style: const TextStyle(color: Colors.grey, fontSize: 12)),
//               ],
//             ),
//           ),
//           Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//         ],
//       ),
//     );
//   }

//   Widget _buildEducationItem(String degree, String uni, String level, String date) {
//     return Row(
//       children: [
//         const Icon(Icons.school_outlined, size: 40, color: Colors.orange),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(degree, style: const TextStyle(fontWeight: FontWeight.bold)),
//               Text(uni, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//             ],
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(level, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//           ],
//         ),
//       ],
//     );
//   }

//   // --- Common Section Header ---
//   Widget _buildSectionHeader(String title, VoidCallback onEdit) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: onEdit),
//         ],
//       ),
//     );
//   }

//   // --- Skills & Languages ---
//   Widget _buildSkillsWrap(List<String> items) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Wrap(
//         spacing: 10, runSpacing: 10,
//         children: items.map((i) => Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Text(i, style: const TextStyle(fontSize: 12)),
//         )).toList(),
//       ),
//     );
//   }

//   // --- CV Section ---
//   Widget _buildCVSection(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("CV", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextButton(onPressed: () {}, child: const Text("Make a CV +", style: TextStyle(color: Color(0xFF334E58)))),
//           ],
//         ),
//         GestureDetector(
//           onTap: () => _showCVModal(context),
//           child: Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade200)),
//             child: Row(
//               children: const [
//                 Icon(Icons.picture_as_pdf, color: Colors.red),
//                 SizedBox(width: 15),
//                 Expanded(child: Text("CV UI Designer Eng.pdf", style: TextStyle(fontWeight: FontWeight.bold))),
//                 Icon(Icons.more_vert),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // --- Modals Functions ---

//   void _showAddExperience(BuildContext context) {
//     _showCustomModal(context, "Add Experience", [
//       _modalField("Job Position"),
//       _modalField("Name Company"),
//       _modalField("Company Address"),
//       Row(children: [Expanded(child: _modalField("Start date")), const SizedBox(width: 10), Expanded(child: _modalField("End date"))]),
//     ], "Add Experience");
//   }

//   void _showAddEducation(BuildContext context) {
//     _showCustomModal(context, "Add Education", [
//       _modalField("University"),
//       _modalField("Degree"),
//       _modalField("Field of study"),
//       Row(children: [Expanded(child: _modalField("Start date")), const SizedBox(width: 10), Expanded(child: _modalField("End date"))]),
//     ], "Add Education");
//   }

//   void _showAddSkill(BuildContext context) {
//     _showCustomModal(context, "Add Skill", [
//       _modalField("Skill (ex: communication)"),
//     ], "Add Skill");
//   }

//   void _showAddLanguage(BuildContext context) {
//     _showCustomModal(context, "Add Language", [
//       _modalField("Language"),
//     ], "Add Language");
//   }

//   void _showCVModal(BuildContext context) {
//      showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("CV", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
//             const SizedBox(height: 20),
//             _cvOption("CV UI Designer Eng.pdf"),
//             const SizedBox(height: 10),
//             _cvOption("CV UI Designer Eng.pdf"),
//             const SizedBox(height: 20),
//             Row(children: [
//               Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Add CV +"))),
//               const SizedBox(width: 15),
//               Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)), onPressed: () {}, child: const Text("Apply Now", style: TextStyle(color: Colors.white)))),
//             ])
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _cvOption(String name) => Container(
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(color: const Color(0xFFFFF9F2), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.orange.shade100)),
//     child: Row(children: [const Icon(Icons.picture_as_pdf, color: Colors.red), const SizedBox(width: 15), Text(name, style: const TextStyle(fontWeight: FontWeight.bold))]),
//   );

//   Widget _modalField(String hint) => Padding(
//     padding: const EdgeInsets.only(bottom: 15),
//     child: TextField(decoration: InputDecoration(hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
//   );

//   void _showCustomModal(BuildContext context, String title, List<Widget> children, String btnText) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 25, right: 25, top: 25),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
//             const SizedBox(height: 20),
//             ...children,
//             const SizedBox(height: 20),
//             SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)), onPressed: () {}, child: Text(btnText, style: const TextStyle(color: Colors.white)))),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// // استيراد الموديلات والبيانات المركزية
// import 'package:workscout/data/model/job_model.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   // دالة مساعدة لحساب عدد المقابلات الحقيقي
//   int _getInterviewCount() {
//     return myApplications.where((app) => app.status == 'Interview').length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBFBFB),
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildProfileHeader(),
//             const SizedBox(height: 30),
//             _buildStatsSection(),
//             const SizedBox(height: 30),
            
//             // قسم الخبرات - ديناميكي
//             _buildSectionHeader("Experience", () => _showAddExperience(context)),
//             ...currentUser.experiences.map((exp) => 
//               _buildExperienceItem(exp.title, exp.company, "Location", exp.date, exp.logo)),
            
//             const SizedBox(height: 25),
//             _buildSectionHeader("Education", () => _showAddEducation(context)),
//             // ملاحظة: يمكنك إضافة قائمة التعليم للموديل بنفس طريقة الخبرات
//             _buildEducationItem("Computer Science", "Indonesia University", "Bachelor (4.0)", "2016 - 2020"),
            
//             const SizedBox(height: 25),
//             _buildSectionHeader("Skill", () => _showAddSkill(context)),
//             _buildSkillsWrap(currentUser.skills),
            
//             const SizedBox(height: 25),
//             _buildSectionHeader("Language", () => _showAddLanguage(context)),
//             _buildSkillsWrap(currentUser.languages),
            
//             const SizedBox(height: 25),
//             _buildCVSection(context),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.settings_outlined, color: Colors.black), 
//           onPressed: () {
//             // هنا يمكنك فتح صفحة الإعدادات لاحقاً
//             print("Settings Clicked");
//           }
//         ),
//         const SizedBox(width: 10),
//       ],
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: NetworkImage(currentUser.profilePic),
//         ),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(currentUser.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(width: 5),
//             const Icon(Icons.edit_outlined, size: 18, color: Colors.blueGrey),
//           ],
//         ),
//         Text(currentUser.location, style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }

//   Widget _buildStatsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         // رقم حقيقي بناءً على طول قائمة التقديمات
//         _statColumn("Applied", "${myApplications.length} Jobs"),
//         _buildDivider(),
//         _statColumn("Reviewed", "0 Jobs"), // سيتم تحديثه عند ربط منطق المراجعة
//         _buildDivider(),
//         // رقم حقيقي بناءً على فلترة قائمة التقديمات لحالة Interview
//         _statColumn("Interview", "${_getInterviewCount()} Jobs"),
//       ],
//     );
//   }

//   Widget _statColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         const SizedBox(height: 5),
//         Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildDivider() => Container(height: 30, width: 1, color: Colors.grey.shade300);

//   Widget _buildExperienceItem(String title, String company, String loc, String date, String logo) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Row(
//         children: [
//           Container(
//             width: 50, height: 50,
//             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//             child: Image.network(logo, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text("$company • $loc", style: const TextStyle(color: Colors.grey, fontSize: 12)),
//               ],
//             ),
//           ),
//           Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//         ],
//       ),
//     );
//   }

//   Widget _buildEducationItem(String degree, String uni, String level, String date) {
//     return Row(
//       children: [
//         const Icon(Icons.school_outlined, size: 40, color: Colors.orange),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(degree, style: const TextStyle(fontWeight: FontWeight.bold)),
//               Text(uni, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//             ],
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(level, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//             Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback onEdit) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: onEdit),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillsWrap(List<String> items) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Wrap(
//         spacing: 10, runSpacing: 10,
//         children: items.map((i) => Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Text(i, style: const TextStyle(fontSize: 12)),
//         )).toList(),
//       ),
//     );
//   }

//   Widget _buildCVSection(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("CV", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextButton(onPressed: () {}, child: const Text("Make a CV +", style: TextStyle(color: Color(0xFF334E58)))),
//           ],
//         ),
//         GestureDetector(
//           onTap: () => _showCVModal(context),
//           child: Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade200)),
//             child: Row(
//               children: const [
//                 Icon(Icons.picture_as_pdf, color: Colors.red),
//                 SizedBox(width: 15),
//                 Expanded(child: Text("CV UI Designer Eng.pdf", style: TextStyle(fontWeight: FontWeight.bold))),
//                 Icon(Icons.more_vert),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // --- Modals المحدثة لتحديث البيانات فعلياً ---

//   void _showAddExperience(BuildContext context) {
//     final posController = TextEditingController();
//     final compController = TextEditingController();

//     _showCustomModal(context, "Add Experience", [
//       _modalField("Job Position", posController),
//       _modalField("Name Company", compController),
//       _modalField("Company Address", TextEditingController()),
//       Row(children: [
//         Expanded(child: _modalField("Start date", TextEditingController())), 
//         const SizedBox(width: 10), 
//         Expanded(child: _modalField("End date", TextEditingController()))
//       ]),
//     ], "Add Experience", () {
//       setState(() {
//         currentUser.experiences.add(Experience(
//           title: posController.text,
//           company: compController.text,
//           date: "Just Now",
//           logo: "https://via.placeholder.com/50",
//         ));
//       });
//       Navigator.pop(context);
//     });
//   }

//   void _showAddSkill(BuildContext context) {
//     final skillController = TextEditingController();
//     _showCustomModal(context, "Add Skill", [
//       _modalField("Skill (ex: communication)", skillController),
//     ], "Add Skill", () {
//       setState(() {
//         if(skillController.text.isNotEmpty) {
//           currentUser.skills.add(skillController.text);
//         }
//       });
//       Navigator.pop(context);
//     });
//   }

//   void _showAddLanguage(BuildContext context) {
//     final langController = TextEditingController();
//     _showCustomModal(context, "Add Language", [
//       _modalField("Language", langController),
//     ], "Add Language", () {
//       setState(() {
//         if(langController.text.isNotEmpty) {
//           currentUser.languages.add(langController.text);
//         }
//       });
//       Navigator.pop(context);
//     });
//   }

//   void _showAddEducation(BuildContext context) {
//      // يمكنك تطبيق نفس منطق الـ Experience هنا عبر إضافة قائمة التعليم للـ UserProfile
//      Navigator.pop(context);
//   }

//   void _showCVModal(BuildContext context) {
//      showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("CV", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
//             const SizedBox(height: 20),
//             _cvOption("CV UI Designer Eng.pdf"),
//             const SizedBox(height: 10),
//             _cvOption("CV UI Designer Eng.pdf"),
//             const SizedBox(height: 20),
//             Row(children: [
//               Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Add CV +"))),
//               const SizedBox(width: 15),
//               Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)), onPressed: () {}, child: const Text("Apply Now", style: TextStyle(color: Colors.white)))),
//             ])
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _cvOption(String name) => Container(
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(color: const Color(0xFFFFF9F2), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.orange.shade100)),
//     child: Row(children: [const Icon(Icons.picture_as_pdf, color: Colors.red), const SizedBox(width: 15), Text(name, style: const TextStyle(fontWeight: FontWeight.bold))]),
//   );

//   Widget _modalField(String hint, TextEditingController controller) => Padding(
//     padding: const EdgeInsets.only(bottom: 15),
//     child: TextField(
//       controller: controller,
//       decoration: InputDecoration(hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))
//     ),
//   );

//   void _showCustomModal(BuildContext context, String title, List<Widget> children, String btnText, VoidCallback onSave) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 25, right: 25, top: 25),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
//             const SizedBox(height: 20),
//             ...children,
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity, 
//               height: 50, 
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)), 
//                 onPressed: onSave, 
//                 child: Text(btnText, style: const TextStyle(color: Colors.white))
//               )
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // لرفع الـ CV
import 'package:workscout/data/datasource/data_test.dart';
import 'package:workscout/data/model/job_model.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  // دالة لحساب عدد المقابلات
  int _getInterviewCount() => myApplications.where((app) => app.status == 'Interview').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildStatsSection(),
            const SizedBox(height: 30),
            
            // قسم الخبرات
            _buildSectionHeader("Experience", () => _showAddExperience(context)),
            ...currentUser.experiences.map((exp) => 
              _buildExperienceItem(exp.title, exp.company, "Remote", exp.date, exp.logo)),
            
            const SizedBox(height: 25),
            
            // قسم التعليم (تم إصلاح الشاشة السوداء)
            _buildSectionHeader("Education", () => _showAddEducation(context)),
            ...currentUser.education.map((edu) => 
              _buildEducationItem(edu.degree, edu.university, edu.level, edu.date)),
            
            const SizedBox(height: 25),
            _buildSectionHeader("Skill", () => _showAddSkill(context)),
            _buildSkillsWrap(currentUser.skills),
            
            const SizedBox(height: 25),
            _buildSectionHeader("Language", () => _showAddLanguage(context)),
            _buildSkillsWrap(currentUser.languages),
            
            const SizedBox(height: 25),
            _buildCVSection(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- 1. تعديل الاسم (Logic) ---
  void _showEditNameDialog() {
    final nameController = TextEditingController(text: currentUser.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(controller: nameController, decoration: const InputDecoration(hintText: "Enter your name")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() => currentUser.name = nameController.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // --- 2. رفع الـ CV (Logic) ---
  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Selected: ${result.files.first.name}")));
    }
  }

  // --- الواجهات (Widgets) ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent, elevation: 0,
      title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [IconButton(icon: const Icon(Icons.settings_outlined, color: Colors.black), onPressed: () {})],
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: NetworkImage(currentUser.profilePic)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentUser.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 5),
            IconButton(icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.blueGrey), onPressed: _showEditNameDialog),
          ],
        ),
        Text(currentUser.location, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statColumn("Applied", "${myApplications.length} Jobs"),
        _buildDivider(),
        _statColumn("Reviewed", "0 Jobs"),
        _buildDivider(),
        _statColumn("Interview", "${_getInterviewCount()} Jobs"),
      ],
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 5),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ]);
  }

  Widget _buildDivider() => Container(height: 30, width: 1, color: Colors.grey.shade300);

  Widget _buildExperienceItem(String title, String company, String loc, String date, String logo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(children: [
        Image.network(logo, width: 50, height: 50, errorBuilder: (c, e, s) => const Icon(Icons.business)),
        const SizedBox(width: 15),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("$company • $loc", style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ])),
        Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ]),
    );
  }

  Widget _buildEducationItem(String degree, String uni, String level, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(children: [
        const Icon(Icons.school_outlined, size: 40, color: Colors.orange),
        const SizedBox(width: 15),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(degree, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(uni, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ])),
        Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ]),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onEdit) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: onEdit),
    ]);
  }

  Widget _buildSkillsWrap(List<String> items) {
    return Align(alignment: Alignment.centerLeft, child: Wrap(spacing: 10, runSpacing: 10, children: items.map((i) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
      child: Text(i, style: const TextStyle(fontSize: 12)),
    )).toList()));
  }

  Widget _buildCVSection(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("CV", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: _pickCV, child: const Text("Make a CV +", style: TextStyle(color: Color(0xFF334E58)))),
      ]),
      GestureDetector(
        onTap: () => _showCVModal(context),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade200)),
          child: Row(children: const [
            Icon(Icons.picture_as_pdf, color: Colors.red),
            SizedBox(width: 15),
            Expanded(child: Text("CV UI Designer Eng.pdf", style: TextStyle(fontWeight: FontWeight.bold))),
            Icon(Icons.more_vert),
          ]),
        ),
      ),
    ]);
  }

  // --- Modals (Fixed) ---

  void _showAddExperience(BuildContext context) {
    final posC = TextEditingController();
    final compC = TextEditingController();
    _showCustomModal(context, "Add Experience", [
      _modalField("Job Position", posC),
      _modalField("Company", compC),
    ], "Add Experience", () {
      setState(() => currentUser.experiences.add(Experience(title: posC.text, company: compC.text, date: "2024", logo: "https://via.placeholder.com/50")));
      Navigator.pop(context);
    });
  }

  void _showAddEducation(BuildContext context) {
    final degC = TextEditingController();
    final uniC = TextEditingController();
    _showCustomModal(context, "Add Education", [
      _modalField("Degree", degC),
      _modalField("University", uniC),
    ], "Add Education", () {
      setState(() => currentUser.education.add(Education(degree: degC.text, university: uniC.text, level: "Bachelor", date: "2024")));
      Navigator.pop(context);
    });
  }

  void _showAddSkill(BuildContext context) {
    final sC = TextEditingController();
    _showCustomModal(context, "Add Skill", [_modalField("Skill", sC)], "Add Skill", () {
      setState(() => currentUser.skills.add(sC.text));
      Navigator.pop(context);
    });
  }

  void _showAddLanguage(BuildContext context) {
    final lC = TextEditingController();
    _showCustomModal(context, "Add Language", [_modalField("Language", lC)], "Add Language", () {
      setState(() => currentUser.languages.add(lC.text));
      Navigator.pop(context);
    });
  }

  void _showCVModal(BuildContext context) {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))), builder: (context) => Container(
      padding: const EdgeInsets.all(25),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("CV", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: _pickCV, child: const Text("Add New CV +")),
      ]),
    ));
  }

  Widget _modalField(String hint, TextEditingController controller) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextField(controller: controller, decoration: InputDecoration(hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
  );

  void _showCustomModal(BuildContext context, String title, List<Widget> children, String btnText, VoidCallback onSave) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 25, right: 25, top: 25),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
          const SizedBox(height: 20),
          ...children,
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)), onPressed: onSave, child: Text(btnText, style: const TextStyle(color: Colors.white)))),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}