// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// abstract class SignupController extends GetxController {
//   signup();
// }

// class SignupControllerImp extends SignupController {
//   GlobalKey<FormState> SignupFormstate = GlobalKey<FormState>();
//   @override
//   signup() {
//     var formdata = SignupFormstate.currentState;
//     if (formdata!.validate()) {
//       Get.offAllNamed("/LoginSucsessView");
//     } else {
//       print("not valid");
//     }
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:workscout/data/datasource/data_test.dart';
import 'package:workscout/services/auth_service.dart'; // تأكد من المسار الصحيح للخدمة

abstract class SignupController extends GetxController {
  signup();
}

class SignupControllerImp extends SignupController {
  GlobalKey<FormState> SignupFormstate = GlobalKey<FormState>();
  
  // تعريف وحدات التحكم للنصوص لسحب البيانات من الحقول
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;

  
  AuthService authService = AuthService(); // استدعاء خدمة الاتصال بالسيرفر


   bool isShowPassword = true; // المتغير المسؤول عن الإخفاء والإظهار

  @override
  showPassword() {
    isShowPassword = !isShowPassword;
    update(); // لتحديث الواجهة (تعمل مع GetBuilder)
  }
  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

@override
signup() async {
  var formdata = SignupFormstate.currentState;
  if (formdata!.validate()) {
    // 1. إذا البيانات صحيحة، رح يطبع هاي الجملة في الـ Console تحت
    print("✅ التحقق سليم، جاري محاولة الاتصال بالسيرفر..."); 

    // 2. طلب التسجيل من السيرفر
    var response = await authService.signup(
      username.text, 
      email.text, 
      password.text
    );
    currentUser.name=username.text;

    // 3. طباعة رد السيرفر عشان نعرف شو صار
    print("📡 رد السيرفر النهائي: $response");

    if (response['message'] == "User created successfully"|| response['message'] =="تم إنشاء الحساب بنجاح") {
      Get.offAllNamed("/LoginView"); // إذا نجح يروح لصفحة النجاح
    } else {
      // إذا فشل (مثلاً الإيميل مكرر) يطلع تنبيه
      Get.defaultDialog(
        title: "تنبيه من السيرفر", 
        middleText: response['message'] ?? "فشل التسجيل"
      );
    }
  } else {
    // 4. إذا البيانات فيها غلط (زي الاسم قصير) رح يطبع هاي
    print("❌ المدخلات غير صالحة، تأكد من تعبئة الحقول صح");
  }
}
}