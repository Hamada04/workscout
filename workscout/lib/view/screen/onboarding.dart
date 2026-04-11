import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:workscout/controller/onboarding_controller.dart';
import 'package:workscout/view/widget/onboarding/custombutton.dart';
import 'package:workscout/view/widget/onboarding/customdot.dart';
import 'package:workscout/view/widget/onboarding/customslider.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 5, child: CustomSliderOnBoarding()),
          Expanded(
            flex: 1,
            child: Column(
              children: const [
                CustomDotOnBoarding(),
                CustomButttonOnBoarding(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
