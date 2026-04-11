import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/authentication_controller/login_controller.dart';
import 'package:workscout/functions/validinput.dart';
import 'package:workscout/view/screen/authintecation/signup_view.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
import 'package:workscout/view/widget/authintecation/custom_check_box.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/authintecation/introduction_widget.dart';
import 'package:workscout/view/widget/authintecation/login_with_google.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  State<LoginView> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      body: Form(
        key: controller.loginFormstate,
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 45),
                    IntroductionWidget(
                      headertext: "Welcome Back to WorkScout",
                      introduction:
                          "Log in to your WorkScout account to continue your job\n"
                          "search, manage applications, and stay updated with the\n"
                          "latest job opportunities.",
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Column(
                        children: [
                          const SizedBox(height: 70),

                          // CustomTextForm(
                          //   valid: (val) {
                          //     return validInput(val!, 5, 100, "email");
                          //   },
                          //   hinttext: "Please enter your email address",
                          //   title: "Email",
                          // ),

                          // CustomTextForm(
                          //   valid: (val) {
                          //     return validInput(val!, 8, 30, "password");
                          //   },
                          //   hinttext: "Please enter your password",
                          //   title: "Password",
                          //   suffixIcon: IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(Icons.visibility),
                          //   ),
                          //   obscureTextStatus: true,
                          // ),
                          // أجزاء من كود LoginView المحدث
CustomTextForm(
  mycontroller: controller.email, // ربط حقل الإيميل
  valid: (val) => validInput(val!, 5, 100, "email"),
  hinttext: "Please enter your email address",
  title: "Email",
),

CustomTextForm(
  mycontroller: controller.password, // ربط حقل كلمة المرور
  valid: (val) => validInput(val!, 8, 30, "password"),
  hinttext: "Please enter your password",
  title: "Password",
  obscureTextStatus: true,
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

                          CustomCheckBox(text: "Remmeber me"),
                          const SizedBox(height: 20),
                          CustomButtonAuth(
                            onPressed: () {
                              controller.login();
                            },
                            text: "Login",
                          ),

                          LoginWithGoogle(text: "Login with Google"),
                          const SizedBox(height: 22),

                          //Don't have an account?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  color: Color(0xff8A8894),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignupView(),
                                    ),
                                  );
                                },

                                child: const Text(
                                  " Sign Up",
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    color: Color(0xff405D72),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Text(
                                " now",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  color: Color(0xff8A8894),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
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
      ),
    );
  }
}
