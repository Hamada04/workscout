import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/api_client.dart';

class JobService {
  Future<List<Job>> fetchJobs({String? category, String? search, int page = 1, int limit = 20}) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (category != null && category.isNotEmpty) queryParams['category'] = category;
    if (search != null && search.isNotEmpty) queryParams['search'] = search;

    final response = await ApiClient.get('/jobs', queryParams: queryParams);
    final List<dynamic> jsonList = response['jobs'] as List<dynamic>;
    return jsonList.map((json) => Job.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Job> fetchJobById(String id) async {
    final response = await ApiClient.get('/jobs/$id');
    return Job.fromJson(response as Map<String, dynamic>);
  }
}
