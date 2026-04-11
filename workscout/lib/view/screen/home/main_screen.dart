import 'package:flutter/material.dart';
import 'package:workscout/view/screen/home/search_page.dart';
import 'package:workscout/view/screen/home/track_job_page.dart';
import 'home.dart';
import 'profile_page.dart';
// import 'search_page.dart'; // استورد صفحة البحث لما تجهزها
// import 'assignment_page.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 1. تحديد الصفحة الحالية
  int _selectedIndex = 0;

  // 2. قائمة الصفحات التي سيتم التنقل بينها
  final List<Widget> _pages = [
    const HomePage(),        // الصفحة رقم 0
    const SearchPage(), // مؤقتاً لحد ما نعمل الـ Search
    const TrackJobPage(), // مؤقتاً
    const ProfilePage(),     // الصفحة رقم 3 (صفحة البروفايل اللي عملناها)
  ];

  // 3. دالة تغيير الصفحة عند الضغط
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الجسم يتغير ديناميكياً حسب الـ index
      body: _pages[_selectedIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // ضروري عشان الأيقونة تنور لما تختارها
        onTap: _onItemTapped,      // تشغيل دالة التغيير عند الضغط
        selectedItemColor: const Color(0xFF334E58),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}