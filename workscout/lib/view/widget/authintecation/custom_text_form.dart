// import 'package:flutter/material.dart';

// class CustomTextForm extends StatelessWidget {
//   const CustomTextForm({
//     super.key,
//     required this.hinttext,
//     this.title,
//     this.suffixIcon,
//     this.obscureTextStatus,
//     required this.valid,
//     this.readonly,
//   });
//   final String hinttext;
//   final String? title;
//   final String? Function(String?) valid;
//   final bool? readonly;

//   final Widget? suffixIcon;
//   final bool? obscureTextStatus;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title != null ? title! : "",
//           style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lato'),
//         ),
//         Container(height: 13),
//         TextFormField(
//           readOnly: readonly ?? false,
//           validator: valid,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),

//             hintText: hinttext,
//             hintStyle: TextStyle(
//               fontFamily: "Lato",
//               color: Color(0xff8A8894),
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//             ),

//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(13),
//               borderSide: BorderSide(color: Color(0xff8A8894), width: 1),
//             ),

//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(13),
//               borderSide: BorderSide(color: Color(0xff8A8894), width: 2),
//             ),
//             suffixIcon: suffixIcon != null
//                 ? IconButton(
//                     padding: EdgeInsets.all(0),
//                     onPressed: () {},
//                     icon: suffixIcon!,
//                   )
//                 : null,
//           ),

//           obscureText: obscureTextStatus != null ? obscureTextStatus! : false,
//         ),
//         const SizedBox(height: 13),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.hinttext,
    this.title,
    this.suffixIcon,
    this.obscureTextStatus,
    required this.valid,
    this.readonly,
    this.mycontroller, // الحقل الجديد المضاف
  });

  final String hinttext;
  final String? title;
  final String? Function(String?) valid;
  final bool? readonly;
  final Widget? suffixIcon;
  final bool? obscureTextStatus;
  final TextEditingController? mycontroller; // تعريف وحدة التحكم

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lato'),
          ),
        const SizedBox(height: 13),
        TextFormField(
          controller: mycontroller, // الربط الفعلي بوحدة التحكم
          readOnly: readonly ?? false,
          validator: valid,
          obscureText: obscureTextStatus ?? false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            hintText: hinttext,
            hintStyle: const TextStyle(
              fontFamily: "Lato",
              color: Color(0xff8A8894),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: Color(0xff8A8894), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: Color(0xff8A8894), width: 2),
            ),
            suffixIcon: suffixIcon, // تم تبسيط الأيقونة لتأخذ الـ Widget مباشرة
          ),
        ),
        const SizedBox(height: 13),
      ],
    );
  }
}