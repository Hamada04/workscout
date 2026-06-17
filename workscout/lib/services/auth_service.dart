import 'package:workscout/services/api_client.dart';

class AuthService {
  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    try {
      final response = await ApiClient.post('/auth/signup', body: {
        'name': name,
        'email': email,
        'password': password,
        'role': 'user',
      });

      if (response is Map<String, dynamic>) {
        return response;
      }
      return {'message': 'Unexpected response format'};
    } catch (e) {
      return {'message': 'Connection Error: $e'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiClient.post('/auth/login', body: {
        'email': email,
        'password': password,
      });

      if (response is Map<String, dynamic>) {
        return response;
      }
      return {'message': 'Unexpected response format'};
    } catch (e) {
      return {'message': 'Connection Error: $e'};
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await ApiClient.put('/auth/update-profile', body: data);

      if (response is Map<String, dynamic>) {
        return response;
      }
      return {'message': 'Unexpected response format'};
    } catch (e) {
      return {'message': 'Connection Error: $e'};
    }
  }
}
