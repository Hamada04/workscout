import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:workscout/controller/personal_customization/personal_controller.dart';
import 'package:workscout/core/constant/color.dart';
import 'package:workscout/functions/validinput.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/personal_customization/personal_button_two.dart';
import 'package:workscout/view/widget/personal_customization/personal_buttone_one.dart';
import 'package:workscout/view/widget/personal_customization/personal_header.dart';
import 'package:workscout/view/widget/personal_customization/personal_title.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalInformationControllerImp controller = Get.put(
      PersonalInformationControllerImp(),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: controller.informformetate,
          child: ListView(
            children: [
              PersonalHeader(
                onPressed: () {
                  Get.toNamed("/ProfesionalProfile");
                },
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: PersonalTitle(text: "Personal Infromation"),
              ),
              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    CustomTextForm(
                      valid: (val) {
                        return validInput(val!, 5, 100, "username");
                      },
                      hinttext: "Your full name",
                      title: "Full Name",
                    ),
                    CustomTextForm(
                      valid: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      hinttext: "Your email addres",
                      title: "Email Addres",
                    ),
                    CustomTextForm(
                      valid: (val) {
                        return validInput(val!, 10, 16, "phone");
                      },
                      hinttext: "Your phone number",
                      title: "Phone Number",
                    ),
                    CustomTextForm(
                      valid: (val) {},
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
              const SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersonalButtoneOne(text: "Back", onPressed: () {}),

                  PersonalButtonTwo(
                    text: "Next",
                    onPressed: () {
                      controller.PersonalInformation();
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
