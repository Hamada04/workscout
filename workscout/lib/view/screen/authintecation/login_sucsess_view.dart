import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';

class LoginSucsessView extends StatelessWidget {
  const LoginSucsessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 165,
              decoration: BoxDecoration(
                color: Color(0xffEAEDEF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xff405D72),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 50, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 23),
            Text(
              "Hi",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Your Registration successfull",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),

            Text(
              "Unlock job offers by completing your profile and let 450+ \n"
              "companies approach you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Lato",
                color: Color(0xff8A8894),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: CustomButtonAuth(
                onPressed: () {
                  // Get.offAllNamed("/LoginView");
                  Get.offAllNamed("/PersonalInformation");
                },
                text: "Continue to Profile",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
