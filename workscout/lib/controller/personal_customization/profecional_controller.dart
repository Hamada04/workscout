import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ProfecionalController extends GetxController {
  profecional();
}

class ProfecionalControllerImp extends ProfecionalController {
  GlobalKey<FormState> profecionalformstate = GlobalKey<FormState>();
  @override
  profecional() {
    var formdata = profecionalformstate.currentState;
    if (formdata!.validate()) {
      Get.offAllNamed("/PersonalCv");
    } else {
      print("not valid");
    }
  }
}
