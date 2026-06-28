// import 'package:flutter/material.dart';
// import 'package:workscout/data/datasource/data_test.dart';
// // مسار الاستيراد الخاص بك
// import 'package:workscout/data/model/job_model.dart';
// import 'package:workscout/view/screen/home/job_details.dart';



// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Job> _searchResults = [];
//   bool _isSearching = false; // هل المستخدم بدأ الكتابة؟
//   bool _showResults = false; // هل تم الضغط على بحث وعرض النتائج؟

//   // دالة البحث وتصفية البيانات من allJobs
//   void _performSearch(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _isSearching = false;
//         _showResults = false;
//         _searchResults = [];
//       } else {
//         _isSearching = true;
//         _showResults = true;
//         _searchResults = allJobs
//             .where((job) =>
//                 job.jobTitle.toLowerCase().contains(query.toLowerCase()) ||
//                 job.companyName.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildSearchBar(),
//       body: _buildBody(),
//     );
//   }

//   // --- AppBar مع حقل البحث ---
//   PreferredSizeWidget _buildSearchBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       title: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: TextField(
//           controller: _searchController,
//           onChanged: _performSearch,
//           onSubmitted: _performSearch,
//           decoration: InputDecoration(
//             hintText: "Search Job",
//             prefixIcon: const Icon(Icons.search, color: Colors.grey),
//             suffixIcon: _searchController.text.isNotEmpty 
//                 ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
//                     _searchController.clear();
//                     _performSearch("");
//                   }) 
//                 : null,
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(vertical: 12),
//           ),
//         ),
//       ),
//     );
//   }

//   // --- التحكم في محتوى الصفحة ---
//   Widget _buildBody() {
//     if (!_isSearching && !_showResults) {
//       return _buildInitialState(); // الحالة قبل البحث
//     } else if (_showResults && _searchResults.isEmpty) {
//       return _buildNotFoundState(); // حالة لا توجد نتائج
//     } else {
//       return _buildResultsState(); // حالة عرض النتائج
//     }
//   }

//   // 1. شاشة البداية (Recent Searches / Categories)
//   Widget _buildInitialState() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _sectionTitle("Recent Searches", true),
//           _recentSearchItem("Design", "Jakarta, Indonesia"),
//           const SizedBox(height: 25),
//           _sectionTitle("Try Searching for", false),
//           _trySearchItem("Product Manager"),
//           _trySearchItem("Product Owner"),
//           _trySearchItem("UI/UX Designer"),
//           const SizedBox(height: 25),
//           _sectionTitle("Popular Categories", false),
//           _popularCategoryItem("Digital Marketing"),
//           _popularCategoryItem("Finance"),
//           _popularCategoryItem("Human Resources"),
//         ],
//       ),
//     );
//   }

//   // 2. شاشة عرض النتائج مع الفلاتر
//   Widget _buildResultsState() {
//     return Column(
//       children: [
//         _buildFiltersRow(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             children: [
//               Text("${_searchResults.length} Jobs Available", 
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             ],
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             itemCount: _searchResults.length,
//             itemBuilder: (context, index) {
//               final job = _searchResults[index];
//               return _buildJobResultCard(job);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // 3. شاشة "لم يتم العثور على نتائج"
//   Widget _buildNotFoundState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.sentiment_dissatisfied, size: 100, color: Colors.blueGrey.shade100),
//           const SizedBox(height: 20),
//           const Text("Not Found", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           const Text("Sorry, no job available", style: TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   // --- عناصر واجهة النتائج (Filters & Cards) ---

//   Widget _buildFiltersRow() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         children: [
//           _filterChip("Filter", Icons.tune, true),
//           _filterChip("Job Role", Icons.keyboard_arrow_down, false),
//           _filterChip("Work Arrangement", Icons.keyboard_arrow_down, false),
//         ],
//       ),
//     );
//   }

//   Widget _filterChip(String label, IconData icon, bool isPrimary) {
//     return GestureDetector(
//       onTap: () => label == "Filter" ? _showFilterModal() : null,
//       child: Container(
//         margin: const EdgeInsets.only(right: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade200),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             if (isPrimary) Icon(icon, size: 18),
//             Text(" $label "),
//             if (!isPrimary) Icon(icon, size: 18),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildJobResultCard(Job job) {
//     return GestureDetector(
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 15),
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Image.network(job.companyLogo, width: 45, height: 45, errorBuilder: (c,e,s) => const Icon(Icons.business)),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       Text("${job.companyName} • ${job.location}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.bookmark_border, color: Colors.grey),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//                 const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // --- عناصر واجهة البداية ---

//   Widget _sectionTitle(String title, bool hasClear) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         if (hasClear) const Text("Clear", style: TextStyle(color: Colors.grey, fontSize: 12)),
//       ],
//     );
//   }

//   Widget _recentSearchItem(String text, String loc) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: const Icon(Icons.history, color: Colors.grey),
//       title: Text(text),
//       subtitle: Text(loc, style: const TextStyle(fontSize: 12)),
//       trailing: const Icon(Icons.close, size: 18),
//     );
//   }

//   Widget _trySearchItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           const Icon(Icons.search, size: 20, color: Colors.grey),
//           const SizedBox(width: 15),
//           Text(text),
//         ],
//       ),
//     );
//   }

//   Widget _popularCategoryItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Text(text, style: const TextStyle(color: Colors.black87)),
//     );
//   }

//   // --- نافذة الفلتر (Filter Modal) ---

//   void _showFilterModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         expand: false,
//         builder: (context, scrollController) => SingleChildScrollView(
//           controller: scrollController,
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Filter", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               _filterSection("Date Posted", ["Anytime", "Last Month", "Last Week", "Last 24 Hours"]),
//               _filterSection("Job Type", ["Full-Time", "Part-Time", "Contract", "Freelance"]),
//               _filterSection("Industry", ["Technology", "Healthcare", "Finance", "Education", "Marketing"]),
//               const SizedBox(height: 30),
//               Row(
//                 children: [
//                   Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Reset"))),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF334E58)),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Apply Now", style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _filterSection(String title, List<String> options) {

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15),
//           child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         ),
//         Wrap(
//           spacing: 10, runSpacing: 10,
//           children: options.map((opt) => Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade200),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(opt, style: const TextStyle(fontSize: 13)),
//           )).toList(),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/job_controller.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/view/screen/home/job_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final JobController _jobCtrl = Get.find<JobController>();
  final TextEditingController _searchController = TextEditingController();
  List<Job> _searchResults = [];
  bool _isSearching = false; 
  bool _showResults = false;

  // قائمة عمليات البحث الأخيرة - قابلة للتحديث
  List<Map<String, String>> _recentSearches = [
    {"title": "Design", "location": "Jakarta, Indonesia"},
  ];

  // دالة البحث المركزية التي تفلتر البيانات وتحدث الحالة
  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _showResults = false;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _showResults = true;
      // تحديث النص في الحقل إذا تم استدعاء الدالة من ضغطة على اقتراح
      if (_searchController.text != query) {
        _searchController.text = query;
        // وضع المؤشر في نهاية النص
        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );
      }
      
      // الفلترة بناءً على المسمى، الشركة، أو التصنيف
      _searchResults = _jobCtrl.jobs.where((job) =>
          job.jobTitle.toLowerCase().contains(query.toLowerCase()) ||
          job.companyName.toLowerCase().contains(query.toLowerCase()) ||
          job.category.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });

    // إضافة البحث للقائمة الأخيرة إذا كان جديداً
    bool exists = _recentSearches.any((s) => s['title']!.toLowerCase() == query.toLowerCase());
    if (!exists && query.trim().isNotEmpty) {
      setState(() {
        _recentSearches.insert(0, {"title": query, "location": "Anywhere"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildSearchBar(),
      body: _buildBody(),
    );
  }

  // --- AppBar مع حقل البحث ---
  PreferredSizeWidget _buildSearchBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _performSearch,
          onSubmitted: _performSearch,
          decoration: InputDecoration(
            hintText: "Search Job",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty 
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20), 
                    onPressed: () {
                      _searchController.clear();
                      _performSearch("");
                    },
                  ) 
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  // --- منطق تبديل المحتوى ---
  Widget _buildBody() {
    if (!_isSearching && !_showResults) {
      return _buildInitialState(); // شاشة الاقتراحات والبحث الأخير
    } else if (_showResults && _searchResults.isEmpty) {
      return _buildNotFoundState(); // شاشة لم يتم العثور على نتائج
    } else {
      return _buildResultsState(); // شاشة عرض الوظائف المفلترة
    }
  }

  // 1. شاشة البداية (Recent Searches / Suggestions / Categories)
  Widget _buildInitialState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Recent Searches", true, () {
            setState(() => _recentSearches.clear());
          }),
          const SizedBox(height: 10),
          ..._recentSearches.map((s) => _recentSearchItem(s['title']!, s['location']!)),
          const SizedBox(height: 25),
          _sectionTitle("Try Searching for", false, null),
          const SizedBox(height: 10),
          _suggestItem("Product Manager"),
          _suggestItem("Product Owner"),
          _suggestItem("UI/UX Designer"),
          _suggestItem("User Researcher"),
          _suggestItem("Visual Designer"),
          const SizedBox(height: 25),
          _sectionTitle("Popular Categories", false, null),
          const SizedBox(height: 15),
          _categoryItem("Digital Marketing"),
          _categoryItem("Business Development"),
          // _categoryItem("Finance"),
          _categoryItem("Technology"),
          _categoryItem("Human Resources"),
        ],
      ),
    );
  }

  // 2. شاشة النتائج
  Widget _buildResultsState() {
    return Column(
      children: [
        _buildFiltersRow(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text("${_searchResults.length} Jobs Available", 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _searchResults.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final job = _searchResults[index];
              return _buildJobResultCard(job);
            },
          ),
        ),
      ],
    );
  }

  // 3. شاشة Not Found
  Widget _buildNotFoundState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle),
            child: Icon(Icons.search_off, size: 80, color: Colors.blueGrey.shade200),
          ),
          const SizedBox(height: 20),
          const Text("Not Found", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Sorry, no job available for this search", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // --- المكونات المساعدة للواجهة ---

  Widget _sectionTitle(String title, bool hasClear, VoidCallback? onClear) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        if (hasClear) 
          GestureDetector(
            onTap: onClear,
            child: const Text("Clear", style: TextStyle(color: Colors.grey, fontSize: 13))
          ),
      ],
    );
  }

  Widget _recentSearchItem(String text, String loc) {
    return ListTile(
      onTap: () => _performSearch(text),
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.history, color: Colors.grey),
      title: Text(text),
      subtitle: Text(loc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: IconButton(
        icon: const Icon(Icons.close, size: 18),
        onPressed: () {
          setState(() {
            _recentSearches.removeWhere((s) => s['title'] == text);
          });
        },
      ),
    );
  }

  Widget _suggestItem(String text) {
    return InkWell(
      onTap: () => _performSearch(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.search, size: 20, color: Colors.grey),
            const SizedBox(width: 15),
            Text(text, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String text) {
    return InkWell(
      onTap: () => _performSearch(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _filterChip("Filter", Icons.tune, true),
          _filterChip("Job Role", Icons.keyboard_arrow_down, false),
          _filterChip("Work Arrangement", Icons.keyboard_arrow_down, false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, IconData icon, bool isPrimary) {
    return GestureDetector(
      onTap: () => label == "Filter" ? _showFilterModal() : null,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (isPrimary) Icon(icon, size: 18),
            Text(" $label "),
            if (!isPrimary) Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildJobResultCard(Job job) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsPage(job: job))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          border: Border.all(color: Colors.grey.shade50),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(job.companyLogo, width: 45, height: 45, errorBuilder: (c,e,s) => const Icon(Icons.business)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("${job.companyName} • ${job.location}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.bookmark_border, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(job.postedDate, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                const Text("View Details", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 20),
            _filterSection("Date Posted", ["Anytime", "Last Month", "Last Week", "Last 24 Hours"]),
            _filterSection("Job Type", ["Full-Time", "Part-Time", "Contract", "Freelance"]),
            _filterSection("Industry", ["Technology", "Healthcare", "Finance", "Marketing"]),
            const Spacer(),
            Row(
              children: [
                Expanded(child: OutlinedButton(
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: () {}, 
                  child: const Text("Reset")
                )),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF334E58),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Apply Now", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _filterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: options.map((opt) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(opt, style: const TextStyle(fontSize: 13)),
          )).toList(),
        ),
      ],
    );
  }
}