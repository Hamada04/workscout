// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// abstract class LoginController extends GetxController {
//   login();
// }

// class LoginControllerImp extends LoginController {
//   GlobalKey<FormState> loginFormstate = GlobalKey<FormState>();
//   @override
//   login() {
//     var formdata = loginFormstate.currentState;
//     if (formdata!.validate()) {
//       Get.offAllNamed("/PersonalInformation");
//     } else {
//       print("not valid");
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/services/auth_service.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> loginFormstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  
  AuthService authService = AuthService();

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  login() async {
    if (loginFormstate.currentState!.validate()) {
      var response = await authService.login(email.text, password.text);

      if (response['token'] != null) {
        // إذا نجح الدخول، ننتقل للشاشة الرئيسية للتطبيق
        Get.offAllNamed("/MainScreen"); 
      } else {
        Get.defaultDialog(
          title: "خطأ",
          middleText: response['message'] ?? "بيانات الدخول غير صحيحة",
        );
      }
    }
  }
}