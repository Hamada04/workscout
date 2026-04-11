import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:workscout/controller/onboarding_controller.dart';
import 'package:workscout/core/constant/color.dart';

class CustomButttonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButttonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      margin: const EdgeInsets.only(top: 25),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 160),
        onPressed: () {
          controller.next();
        },
        color: AppColor.butoonColor,
        textColor: Colors.white,
        child: Text("Next "),
      ),
    );
  }
}
