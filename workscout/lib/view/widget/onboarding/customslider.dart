import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:workscout/controller/onboarding_controller.dart';
import 'package:workscout/core/constant/color.dart';
import 'package:workscout/data/datasource/static/onboarding_static.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) => Column(
        children: [
          Image.asset(onBoardingList[i].image!),
          SizedBox(height: 70),
          Text(
            onBoardingList[i].title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
          SizedBox(height: 45),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              onBoardingList[i].body!,
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5, color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  }
}
