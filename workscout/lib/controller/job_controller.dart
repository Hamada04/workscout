import 'package:get/get.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/job_service.dart';
import 'package:workscout/controller/auth_controller.dart';

class JobController extends GetxController {
  final JobService _jobService = JobService();

  final RxList<Job> jobs = RxList<Job>();
  final RxList<Job> savedJobs = RxList<Job>();
  final RxBool isLoading = RxBool(true);
  final RxString errorMessage = RxString('');

  Set<String> get savedJobIds => savedJobs.map((j) => j.id).toSet();

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

  Future<void> fetchSavedJobs() async {
    try {
      final result = await _jobService.fetchSavedJobs();
      savedJobs.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> toggleBookmark(String jobId) async {
    final authCtrl = Get.find<AuthController>();
    final user = authCtrl.currentUser.value;
    if (user == null) return;

    final isSaved = user.savedJobsIds.contains(jobId);

    try {
      if (isSaved) {
        await _jobService.unsaveJob(jobId);
        user.savedJobsIds.remove(jobId);
        savedJobs.removeWhere((j) => j.id == jobId);
      } else {
        await _jobService.saveJob(jobId);
        user.savedJobsIds.add(jobId);
      }
      authCtrl.currentUser.refresh();
    } catch (e) {
      rethrow;
    }
  }
}
