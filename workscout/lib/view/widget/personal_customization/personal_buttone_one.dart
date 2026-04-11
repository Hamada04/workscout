import 'package:flutter/material.dart';
import 'package:workscout/core/constant/color.dart';

class PersonalButtoneOne extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const PersonalButtoneOne({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          side: BorderSide(color: AppColor.butoonColor),
          minimumSize: const Size(170, 45),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 15,
            color: AppColor.butoonColor,
          ),
        ),
      ),
    );
  }
}
