import 'package:flutter/material.dart';

class PersonalHeader extends StatelessWidget {
  final Function() onPressed;
  const PersonalHeader({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/Logo.png", width: 65, height: 65),
        SizedBox(width: 3),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Workscout",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 143),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              "skip",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
