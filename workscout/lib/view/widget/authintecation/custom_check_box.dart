import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  const CustomCheckBox({super.key, required this.text});

  @override
  State<CustomCheckBox> createState() {
    return _CustomCheckBoxState();
  }
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool statusofRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            activeColor: Color(0xff0A66C2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(width: 0, color: Color(0xff8A8894)),
            ),

            value: statusofRememberMe,
            onChanged: (value) {
              setState(() {
                statusofRememberMe = value!;
              });
            },
          ),
        ),

        Text(
          widget.text,
          style: TextStyle(
            fontFamily: "Lato",
            color: Color(0xff8A8894),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
