import 'package:flutter/material.dart';
class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle ({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
Image.asset(width: 26,height: 50,"assets/images/GoogleIcon.png"),
Text(text,style: TextStyle(
fontFamily: "Lato",
color: Color(0xff8A8894),
fontWeight: FontWeight.w400,
fontSize: 14,
),)
],
);
  }
}
