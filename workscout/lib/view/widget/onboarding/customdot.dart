import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/onboarding_controller.dart';
import 'package:workscout/core/constant/color.dart';
import 'package:workscout/data/datasource/static/onboarding_static.dart';

class CustomDotOnBoarding extends StatelessWidget {
  const CustomDotOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      init: OnBoardingControllerImp(),
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ...List.generate(
            onBoardingList.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 7, top: 0.1),
              duration: Duration(milliseconds: 900),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: controller.cuurentPage == index
                    ? AppColor.butoonColor
                    : AppColor.dotColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
