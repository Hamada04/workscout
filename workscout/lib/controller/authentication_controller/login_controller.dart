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
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/services/auth_service.dart';
import 'package:workscout/services/token_storage.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> loginFormstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  
  AuthService authService = AuthService();
  final TokenStorage _tokenStorage = TokenStorage();

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
        await _tokenStorage.saveToken(response['token'] as String);

        if (response['user'] != null) {
          final authCtrl = Get.find<AuthController>();
          await authCtrl.setUserFromLogin(response['user'] as Map<String, dynamic>);
        }

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