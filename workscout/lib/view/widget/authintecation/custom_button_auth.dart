import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 43,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),

      child: Text(text, style: TextStyle(fontFamily: "Lato", fontSize: 15)),


      color: Color(0xff405D72),
      textColor: Colors.white,
    );
  }
}
