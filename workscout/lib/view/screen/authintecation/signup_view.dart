// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:workscout/controller/authentication_controller/signup_controller.dart';
// import 'package:workscout/functions/validinput.dart';
// import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
// import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
// import 'package:workscout/view/widget/authintecation/introduction_widget.dart';
// import 'package:workscout/view/widget/authintecation/login_with_google.dart';

// class SignupView extends StatefulWidget {
//   const SignupView({super.key});

//   State<SignupView> createState() {
//     return _SignupViewState();
//   }
// }

// class _SignupViewState extends State<SignupView> {
//   @override
//   Widget build(BuildContext context) {
//     SignupControllerImp controller = Get.put(SignupControllerImp());
//     return Scaffold(
//       body: Container(
//         child: Form(
//           key: controller.SignupFormstate,
//           child: ListView(
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 45),
//                     IntroductionWidget(
//                       headertext: "Create Your WorkScout Account",
//                       introduction:
//                           "Join WorkScout to find your perfect job. Create an\n"
//                           "account for personalized matches and career resources",
//                     ),

//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 26),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 45),

//                           CustomTextForm(
//                             valid: (val) {
//                               return validInput(val!, 6, 20, "username");
//                             },
//                             hinttext: "Please enter your full name",
//                             title: "Full Name",
//                           ),
//                           //email address
//                           CustomTextForm(
//                             valid: (val) {
//                               return validInput(val!, 5, 100, "email");
//                             },
//                             hinttext: "Please enter your email address",
//                             title: "Email",
//                           ),
//                           //password
//                           CustomTextForm(
//                             valid: (val) {
//                               return validInput(val!, 8, 30, "password");
//                             },
//                             hinttext: "Please enter your password",
//                             title: "Password",
//                             suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.visibility),
//                             ),
//                             obscureTextStatus: true,
//                           ),

//                           Container(
//                             alignment: Alignment.bottomLeft,
//                             child: const Text(
//                               "Password must be at least 8 characters long",
//                               style: TextStyle(
//                                 fontFamily: "Lato",
//                                 color: Color(0xff8A8894),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),

//                           SizedBox(height: 20),
//                           CustomButtonAuth(
//                             onPressed: () {
//                               controller.signup();
//                             },
//                             text: "Sign Up",
//                           ),

//                           LoginWithGoogle(text: "Sign Up with Google"),
//                           SizedBox(height: 22),

//                           //Already have an account?
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Already have an account?",
//                                 style: TextStyle(
//                                   fontFamily: "Lato",
//                                   color: Color(0xff8A8894),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                 ),
//                               ),

//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },

//                                 child: const Text(
//                                   " Login",
//                                   style: TextStyle(
//                                     fontFamily: "Lato",
//                                     color: Color(0xff405D72),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                               const Text(
//                                 " here",
//                                 style: TextStyle(
//                                   fontFamily: "Lato",
//                                   color: Color(0xff8A8894),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/authentication_controller/signup_controller.dart';
import 'package:workscout/functions/validinput.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/authintecation/introduction_widget.dart';
import 'package:workscout/view/widget/authintecation/login_with_google.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool obsecureText=true;
  @override
  Widget build(BuildContext context) {
    // استخدام Get.put لإنشاء الكنترولر وإتاحته في الصفحة
    SignupControllerImp controller = Get.put(SignupControllerImp());
    

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
                        // حقل الاسم الكامل
                        CustomTextForm(
                          mycontroller: controller.username, // الربط بالكنترولر
                          valid: (val) => validInput(val!, 6, 20, "username"),
                          hinttext: "Please enter your full name",
                          title: "Username",
                        ),
                        // حقل البريد الإلكتروني
                        CustomTextForm(
                          mycontroller: controller.email, // الربط بالكنترولر
                          valid: (val) => validInput(val!, 5, 100, "email"),
                          hinttext: "Please enter your email address",
                          title: "Email",
                        ),
                        // حقل كلمة المرور
                        CustomTextForm(
                          mycontroller: controller.password, // الربط بالكنترولر
                          valid: (val) => validInput(val!, 8, 30, "password"),
                          hinttext: "Please enter your password",
                          title: "Password",
                          
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureText=!obsecureText;
                              });
                              // هنا يمكنك إضافة منطق إظهار/إخفاء كلمة المرور لاحقاً
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
                        // const LoginWithGoogle(text: "Sign Up with Google"),
                        const SizedBox(height: 22),
                        // منطق الانتقال لصفحة تسجيل الدخول
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
                                Get.toNamed("/LoginView"); // العودة لصفحة الـ Login
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