import 'package:flutter/material.dart';
import 'package:workscout/core/constant/color.dart';

class PersonalButtonTwo extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const PersonalButtonTwo({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.butoonColor,
        minimumSize: const Size(170, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontFamily: "Lato", fontSize: 15, color: Colors.white),
      ),
    );
  }
}
