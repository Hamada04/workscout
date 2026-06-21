import 'package:workscout/services/api_client.dart';

class ApplicationService {
  Future<Map<String, dynamic>> createApplication({
    required String jobId,
    String? filePath,
    String? fileName,
    List<int>? bytes,
    String coverLetter = '',
    String cvUrl = '',
  }) async {
    final fields = <String, String>{
      'jobId': jobId,
      'coverLetter': coverLetter,
    };
    if (cvUrl.isNotEmpty) {
      fields['cvUrl'] = cvUrl;
    }
    final response = await ApiClient.postMultipart(
      '/admin/applications/create',
      fields: fields,
      fileField: (filePath != null || bytes != null) ? 'cv' : null,
      filePath: filePath,
      fileName: fileName,
      bytes: bytes,
    );
    return response as Map<String, dynamic>;
  }
}
