import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:workscout/routes.dart';
// لا داعي لاستيراد كل الصفحات هنا لأننا نستخدم ملف routes.dart الخارجي

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorkScout App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // بدلاً من استخدام home، نستخدم initialRoute ليعتمد على التقسيم الموجود في ملف routes.dart
      initialRoute: "/", 
      routes: routes,
    );
  }
}