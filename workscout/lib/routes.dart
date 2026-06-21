// import 'package:flutter/material.dart';
// import 'package:workscout/view/screen/authintecation/login_sucsess_view.dart';
// import 'package:workscout/view/screen/authintecation/login_view.dart';
// import 'package:workscout/view/screen/personal_customization/personal_cv.dart';
// import 'package:workscout/view/screen/personal_customization/personal_information.dart';
// import 'package:workscout/view/screen/personal_customization/profesional_profile.dart';

// Map<String, Widget Function(BuildContext)> routes = {
//   "/LoginView": (context) => LoginView(),
//   "/PersonalInformation": (context) => PersonalInformation(),
//   "/ProfesionalProfile": (context) => ProfesionalProfile(),
//   "/PersonalCv": (context) => PersonalCv(),
//   "/LoginSucsessView": (context) => LoginSucsessView(),
// };
import 'package:flutter/material.dart';
// استيراد الصفحات الجديدة
import 'package:workscout/view/screen/authintecation/signup_view.dart';
import 'package:workscout/view/screen/home/gemini_recommendation_page.dart';
import 'package:workscout/view/screen/home/main_screen.dart'; // تأكد من المسار الصحيح لصفحتك الرئيسية
import 'package:workscout/view/screen/authintecation/login_sucsess_view.dart';
import 'package:workscout/view/screen/authintecation/login_view.dart';
import 'package:workscout/view/screen/personal_customization/personal_cv.dart';
import 'package:workscout/view/screen/personal_customization/personal_information.dart';
import 'package:workscout/view/screen/personal_customization/profesional_profile.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // نقطة البداية الجديدة (Signup)
  "/": (context) => const SignupView(), 
  "/SignupView": (context) => const SignupView(),
  
  // صفحات الموثوقية
  "/LoginView": (context) => const LoginView(),
  "/LoginSucsessView": (context) => const LoginSucsessView(),
  
  // الصفحة الرئيسية (التي تظهر بعد تسجيل الدخول الناجح)
  "/MainScreen": (context) => const MainScreen(), 

  // صفحات الملف الشخصي
  "/PersonalInformation": (context) => const PersonalInformation(),
  "/ProfesionalProfile": (context) => const ProfesionalProfile(),
  "/PersonalCv": (context) => const PersonalCv(),
  "/GeminiRecommendationPage": (context) => const GeminiRecommendationPage(),
};