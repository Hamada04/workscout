import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/view/screen/home/home.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
import 'package:workscout/view/widget/authintecation/custom_check_box.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/personal_customization/personal_title.dart';

class PersonalCv extends StatelessWidget {
  const PersonalCv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/Logo.png", width: 65, height: 65),
                SizedBox(width: 3),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Workscout",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: PersonalTitle(
                text:
                    "Upload your CV to get analyzed and \n receive job offers.",
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  CustomTextForm(
                    valid: (val) {},
                    readonly: true,
                    hinttext: "Upload your CV in pdf",
                    title: "CV",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle),
                    ),
                  ),
                  CustomTextForm(
                    valid: (val) {},
                    hinttext: "URL Links",
                    title: "Protfoilo(opitional)",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  CustomCheckBox(
                    text:
                        "I agree to the terms and conditions and privacy\npolicy of the application ",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 278),

            CustomButtonAuth(
              text: "Get Started",
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => JobPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
