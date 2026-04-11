import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:workscout/data/datasource/static/onboarding_static.dart';

abstract class OnBoardingContoller extends GetxController {
  next();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingContoller {
  late PageController pageController;
  int cuurentPage = 0;
  @override
  next() {
    cuurentPage++;

    if (cuurentPage > onBoardingList.length - 1) {
      Get.offAllNamed("/LoginView");
    } else {
      pageController.animateToPage(
        cuurentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  onPageChanged(int index) {
    cuurentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
