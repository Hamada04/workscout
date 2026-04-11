import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    super.key,
    required this.headertext,
    required this.introduction,
  });
  final String headertext;
  final String introduction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/Logo.png", width: 100, height: 100),
        SizedBox(height: 10),
        Text(
          headertext,

          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 27),

        Text(
          introduction,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff8A8894),
            fontFamily: "Lato",

            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
