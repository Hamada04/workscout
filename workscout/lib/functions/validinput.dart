// // import 'package:get/utils.dart';

// // validInput(String val, int min, int max, String type) {
// //   if (type == "username") {
// //     if (!GetUtils.isUsername(val)) {
// //       return "not valid username";
// //     }
// //   }
// //   if (type == "email") {
// //     if (!GetUtils.isEmail(val)) {
// //       return "not valid email";
// //     }
// //   }
// //   if (type == "phone") {
// //     if (!GetUtils.isPhoneNumber(val)) {
// //       return "not valid phone number";
// //     }
// //   }

// //   if (val.isEmpty) {
// //     return "cant be empty";
// //   }
// //   if (val.length < min) {
// //     return "cant be less than $min";
// //   }
// //   if (val.length > max) {
// //     return "cant be larger than $max";
// //   }
// // }
// import 'package:get/get_utils/src/get_utils/get_utils.dart';

// validInput(String val, int min, int max, String type) {
//   // فحص إذا كان الحقل فارغاً أولاً
//   if (val.isEmpty) {
//     return "can't be empty";
//   }

//   // فحص الإيميل
//   if (type == "email") {
//     if (!GetUtils.isEmail(val)) {
//       return "not valid email";
//     }
//   }

//   // فحص رقم الهاتف
//   if (type == "phone") {
//     if (!GetUtils.isPhoneNumber(val)) {
//       return "not valid phone number";
//     }
//   }

//   // تم إلغاء GetUtils.isUsername لأنها لا تقبل الفراغات في الأسماء الكاملة
//   // نكتفي بفحص الطول فقط لنوع username (الاسم الكامل)
  
//   if (val.length < min) {
//     return "can't be less than $min";
//   }

//   if (val.length > max) {
//     return "can't be larger than $max";
//   }
// }
import 'package:get/get_utils/src/get_utils/get_utils.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "can't be empty"; // التأكد إن الحقل مش فارغ
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    }
  }

  // ملاحظة: شلنا GetUtils.isUsername عشان يقبل اسمك الكامل حتى لو فيه فراغات
  if (val.length < min) {
    return "can't be less than $min";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }
}