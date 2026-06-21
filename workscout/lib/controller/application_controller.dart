import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/api_client.dart';
import 'package:workscout/services/application_service.dart';

class ApplicationController extends GetxController {
  final ApplicationService _applicationService = ApplicationService();

  final RxBool isSubmitting = RxBool(false);
  final RxString errorMessage = RxString('');
  final RxList<JobApplication> myApplications = <JobApplication>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyApplications();
  }

  Future<void> fetchMyApplications() async {
    try {
      final response = await ApiClient.get('/applications/my-applications');
      final List<dynamic> data = response is List ? response : (response['applications'] ?? []);
      myApplications.assignAll(data.map((e) => JobApplication.fromJson(e as Map<String, dynamic>)));
    } catch (e) {
      debugPrint('[ApplicationController] fetchMyApplications error: $e');
      Get.snackbar(
        'Sync Error',
        'Could not load applications.\n$e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
      );
    }
  }

  Future<void> apply({
    required String jobId,
    String? filePath,
    String? fileName,
    List<int>? bytes,
    required String coverLetter,
    String cvUrl = '',
  }) async {
    isSubmitting.value = true;
    errorMessage.value = '';
    try {
      await _applicationService.createApplication(
        jobId: jobId,
        filePath: filePath,
        fileName: fileName,
        bytes: bytes,
        coverLetter: coverLetter,
        cvUrl: cvUrl,
      );

      await fetchMyApplications();

      Get.dialog(
        AlertDialog(
          title: const Text("Success"),
          content: const Text("Your application has been submitted!"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to submit application.\n${e.toString()}",
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
