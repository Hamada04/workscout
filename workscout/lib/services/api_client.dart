import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:workscout/services/api_config.dart';
import 'package:workscout/services/token_storage.dart';

class ApiClient {
  static final TokenStorage _tokenStorage = TokenStorage();

  static Future<Map<String, String>> _getHeaders({bool isMultipart = false}) async {
    final headers = <String, String>{};
    if (!isMultipart) {
      headers['Content-Type'] = 'application/json';
    }
    final token = await _tokenStorage.readToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      await _tokenStorage.deleteToken();
      Get.offAllNamed('/LoginView');
      throw Exception('Unauthorized');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      return jsonDecode(response.body);
    }
    final body = response.body.isNotEmpty ? response.body : 'Unknown error';
    throw Exception('HTTP ${response.statusCode}: $body');
  }

  static Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint').replace(queryParameters: queryParams);
    final headers = await _getHeaders();
    final response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final response = await http.post(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final response = await http.put(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final response = await http.delete(uri, headers: headers);
    return _handleResponse(response);
  }

  static Future<dynamic> postMultipart(
    String endpoint, {
    required Map<String, String> fields,
    String? fileField,
    String? filePath,
    String? fileName,
    List<int>? bytes,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders(isMultipart: true);
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    if (fileField != null) {
      if (bytes != null) {
        request.files.add(http.MultipartFile.fromBytes(fileField, bytes, filename: fileName, contentType: http.MediaType('application', 'pdf')));
      } else if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath(fileField, filePath, filename: fileName));
      }
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }
}
