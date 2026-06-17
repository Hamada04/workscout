import 'package:workscout/services/api_client.dart';

class ApplicationService {
  Future<Map<String, dynamic>> createApplication({
    required String jobId,
    required String filePath,
    required String fileName,
    String coverLetter = '',
  }) async {
    final response = await ApiClient.postMultipart(
      '/admin/applications/create',
      fields: {
        'jobId': jobId,
        'coverLetter': coverLetter,
      },
      fileField: 'cv',
      filePath: filePath,
      fileName: fileName,
    );
    return response as Map<String, dynamic>;
  }
}
