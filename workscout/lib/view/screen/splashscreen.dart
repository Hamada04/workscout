import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:workscout/core/constant/imageassets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workscout/view/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfffffcf8),
      body: Center(
        child:
            Image.asset(
                  "assets/images/splashscreen.png",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                )
                .animate(
                  onComplete: (o) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const OnBoarding(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                )
                .fadeIn(duration: Duration(milliseconds: 950))
                .fadeOut(
                  delay: Duration(milliseconds: 1300),
                  duration: Duration(milliseconds: 700),
                ),
      ),
    );
  }
}
