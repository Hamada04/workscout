import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // ملاحظة: استخدم IP جهازك أو 10.0.2.2 إذا كنت تستخدم المحاكي (Emulator)
  final String baseUrl = "http://10.0.2.2:3000/api/auth";

  // دالة إنشاء حساب جديد
  // Future<Map<String, dynamic>> signup(String name, String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/signup'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "name": name,
  //       "email": email,
  //       "password": password,
  //       "role": "user" // نحدد هنا أنه مستخدم عادي
  //     }),
  //   );
  //   return jsonDecode(response.body);
  // }
Future<Map<String, dynamic>> signup(String name, String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role": "user"
      }),
    );

    // طباعة نص الرد القادم من السيرفر للتأكد منه
    print("📥 نص الرد القادم من السيرفر: ${response.body}");

    if (response.headers['content-type']?.contains('application/json') ?? false) {
      return jsonDecode(response.body);
    } else {
      // إذا لم يكن الرد JSON، أرجع رسالة خطأ بدلاً من تحطيم التطبيق
      return {"message": "Server returned HTML instead of JSON. Check your URL or Server logs."};
    }
  } catch (e) {
    print("❌ خطأ في الاتصال: $e");
    return {"message": "Connection Error"};
  }
}
Future<Map<String, dynamic>> updateProfile(String userId, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update-profile/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
}
  // دالة تسجيل الدخول
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return jsonDecode(response.body);
  }
}