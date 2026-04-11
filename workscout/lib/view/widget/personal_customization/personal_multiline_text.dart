import 'package:flutter/material.dart';

class PersonalMultilineText extends StatelessWidget {
  final String text;
  final String hintText;
  final String? Function(String?) valid;
  const PersonalMultilineText({
    super.key,
    required this.text,
    required this.hintText,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 250),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lato'),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            TextFormField(
              validator: valid,
              maxLines: 5,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: "Lato",
                  color: Color(0xff8A8894),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                alignLabelWithHint: true,
                counterText: "",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xff8A8894), width: 1),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xff8A8894), width: 2),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "100",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
