import 'package:get/get.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/job_service.dart';

class JobController extends GetxController {
  final JobService _jobService = JobService();

  final RxList<Job> jobs = RxList<Job>();
  final RxBool isLoading = RxBool(true);
  final RxString errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs({String? category, String? search}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _jobService.fetchJobs(category: category, search: search);
      jobs.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
