import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workscout/services/application_service.dart';

class ApplicationController extends GetxController {
  final ApplicationService _applicationService = ApplicationService();

  final RxBool isSubmitting = RxBool(false);
  final RxString errorMessage = RxString('');

  Future<void> apply({
    required String jobId,
    required String filePath,
    required String fileName,
    required String coverLetter,
  }) async {
    isSubmitting.value = true;
    errorMessage.value = '';
    try {
      await _applicationService.createApplication(
        jobId: jobId,
        filePath: filePath,
        fileName: fileName,
        coverLetter: coverLetter,
      );

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
