import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/services/api_client.dart';

abstract class ProfecionalController extends GetxController {
  profecional();
}

class ProfecionalControllerImp extends ProfecionalController {
  GlobalKey<FormState> profecionalformstate = GlobalKey<FormState>();

  late TextEditingController positionCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController locationCtrl;

  @override
  void onInit() {
    super.onInit();
    final user = Get.find<AuthController>().currentUser.value;
    positionCtrl = TextEditingController(text: user?.position ?? '');
    phoneCtrl = TextEditingController();
    locationCtrl = TextEditingController(text: user?.location ?? '');
  }

  @override
  void onClose() {
    positionCtrl.dispose();
    phoneCtrl.dispose();
    locationCtrl.dispose();
    super.onClose();
  }

  @override
  profecional() async {
    var formdata = profecionalformstate.currentState;
    if (formdata!.validate()) {
      try {
        await ApiClient.put('/auth/update-profile', body: {
          'position': positionCtrl.text,
          'phone': phoneCtrl.text,
          'location': locationCtrl.text,
        });
        await Get.find<AuthController>().fetchProfile();
        Get.offAllNamed("/PersonalCv");
      } catch (e) {
        Get.snackbar('Error', 'Failed to save: $e');
      }
    } else {
      print("not valid");
    }
  }
}
