import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class PersonalInformationController extends GetxController {
  PersonalInformation();
}

class PersonalInformationControllerImp extends PersonalInformationController {
  GlobalKey<FormState> informformetate = GlobalKey<FormState>();
  @override
  PersonalInformation() {
    var formdata = informformetate.currentState;
    if (formdata!.validate()) {
      Get.toNamed("/ProfesionalProfile");
    } else {
      print("not valid");
    }
  }
}
