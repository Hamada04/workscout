import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/application_controller.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/controller/job_controller.dart';
import 'package:workscout/controller/notification_controller.dart';
import 'package:workscout/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(JobController());
    Get.lazyPut(() => ApplicationController());
    Get.lazyPut(() => NotificationController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorkScout App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/", 
      routes: routes,
    );
  }
}