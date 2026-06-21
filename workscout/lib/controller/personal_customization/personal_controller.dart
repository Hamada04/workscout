import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/services/api_client.dart';

abstract class PersonalInformationController extends GetxController {
  PersonalInformation();
}

class PersonalInformationControllerImp extends PersonalInformationController {
  GlobalKey<FormState> informformetate = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController locationCtrl;

  @override
  void onInit() {
    super.onInit();
    final user = Get.find<AuthController>().currentUser.value;
    nameCtrl = TextEditingController(text: user?.name ?? '');
    emailCtrl = TextEditingController(text: user?.email ?? '');
    phoneCtrl = TextEditingController();
    locationCtrl = TextEditingController(text: user?.location ?? '');
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    locationCtrl.dispose();
    super.onClose();
  }

  @override
  PersonalInformation() async {
    var formdata = informformetate.currentState;
    if (formdata!.validate()) {
      try {
        await ApiClient.put('/auth/update-profile', body: {
          'name': nameCtrl.text,
          'email': emailCtrl.text,
          'phone': phoneCtrl.text,
          'location': locationCtrl.text,
        });
        await Get.find<AuthController>().fetchProfile();
        Get.toNamed("/ProfesionalProfile");
      } catch (e) {
        Get.snackbar('Error', 'Failed to save: $e');
      }
    } else {
      print("not valid");
    }
  }
}
