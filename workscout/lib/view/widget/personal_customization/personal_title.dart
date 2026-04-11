import 'package:flutter/material.dart';

class PersonalTitle extends StatelessWidget {
  final String text;
  const PersonalTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
