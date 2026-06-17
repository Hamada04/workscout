import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/authentication_controller/signup_controller.dart';
import 'package:workscout/functions/validinput.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/authintecation/introduction_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late SignupControllerImp controller;
  bool obsecureText = true;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SignupControllerImp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.SignupFormstate,
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  const IntroductionWidget(
                    headertext: "Create Your WorkScout Account",
                    introduction: "Join WorkScout to find your perfect job. Create an\n"
                        "account for personalized matches and career resources",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        const SizedBox(height: 45),
                        CustomTextForm(
                          mycontroller: controller.username,
                          valid: (val) => validInput(val!, 6, 20, "username"),
                          hinttext: "Please enter your full name",
                          title: "Username",
                        ),
                        CustomTextForm(
                          mycontroller: controller.email,
                          valid: (val) => validInput(val!, 5, 100, "email"),
                          hinttext: "Please enter your email address",
                          title: "Email",
                        ),
                        CustomTextForm(
                          mycontroller: controller.password,
                          valid: (val) => validInput(val!, 8, 30, "password"),
                          hinttext: "Please enter your password",
                          title: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                            icon: Icon(obsecureText ? Icons.visibility_off : Icons.visibility),
                          ),
                          obscureTextStatus: obsecureText,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "Password must be at least 8 characters long",
                            style: TextStyle(
                              fontFamily: "Lato",
                              color: Color(0xff8A8894),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButtonAuth(
                          onPressed: () {
                            controller.signup();
                          },
                          text: "Sign Up",
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontFamily: "Lato",
                                color: Color(0xff8A8894),
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/LoginView");
                              },
                              child: const Text(
                                " Login",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  color: Color(0xff405D72),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Text(" here", style: TextStyle(fontSize: 14, color: Color(0xff8A8894))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
