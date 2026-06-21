import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/personal_customization/profecional_controller.dart';
import 'package:workscout/core/constant/color.dart';
import 'package:workscout/functions/validinput.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/personal_customization/personal_button_two.dart';
import 'package:workscout/view/widget/personal_customization/personal_buttone_one.dart';
import 'package:workscout/view/widget/personal_customization/personal_header.dart';
import 'package:workscout/view/widget/personal_customization/personal_multiline_text.dart';
import 'package:workscout/view/widget/personal_customization/personal_title.dart';

class ProfesionalProfile extends StatefulWidget {
  const ProfesionalProfile({super.key});

  @override
  State<ProfesionalProfile> createState() => _ProfesionalProfileState();
}

class _ProfesionalProfileState extends State<ProfesionalProfile> {
  late ProfecionalControllerImp controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfecionalControllerImp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: controller.profecionalformstate,
          child: ListView(
            children: [
              PersonalHeader(
                onPressed: () {
                  Get.toNamed("/PersonalCv");
                },
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: PersonalTitle(text: "Profecional Profile"),
              ),
              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    CustomTextForm(
                      mycontroller: controller.positionCtrl,
                      valid: (val) {
                        return validInput(val!, 5, 20, "");
                      },
                      hinttext: "e.g UI/UX Desiner. Project Manger ",
                      title: "Profecional profile",
                    ),
                    PersonalMultilineText(
                      valid: (val) {
                        return validInput(val!, 5, 100, "");
                      },
                      text: "Profile Summary",
                      hintText: "Your profecional profile summary",
                    ),
                    CustomTextForm(
                      mycontroller: controller.phoneCtrl,
                      valid: (val) {
                        return validInput(val!, 10, 15, "phone");
                      },
                      hinttext: "Your phone number",
                      title: "Phone Number",
                    ),
                    CustomTextForm(
                      mycontroller: controller.locationCtrl,
                      valid: (val) => null,
                      hinttext: "Your location",
                      title: "Location",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.location_on_outlined),
                        color: AppColor.butoonColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersonalButtoneOne(
                    text: "Back",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  PersonalButtonTwo(
                    text: "Next",
                    onPressed: () {
                      controller.profecional();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
