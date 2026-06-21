import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/services/api_client.dart';
import 'package:workscout/view/widget/authintecation/custom_button_auth.dart';
import 'package:workscout/view/widget/authintecation/custom_check_box.dart';
import 'package:workscout/view/widget/authintecation/custom_text_form.dart';
import 'package:workscout/view/widget/personal_customization/personal_title.dart';

class PersonalCv extends StatefulWidget {
  const PersonalCv({super.key});

  @override
  State<PersonalCv> createState() => _PersonalCvState();
}

class _PersonalCvState extends State<PersonalCv> {
  late final AuthController authCtrl;
  late final TextEditingController cvCtrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    authCtrl = Get.find<AuthController>();
    cvCtrl = TextEditingController(text: authCtrl.currentUser.value?.cvUrl ?? '');
  }

  @override
  void dispose() {
    cvCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    if (result == null) return;

    setState(() => _isUploading = true);
    try {
      final file = result.files.first;
      final String? path = file.path;
      final List<int>? bytes = file.bytes;

      if (path == null && bytes == null) {
        throw Exception('File path and bytes are both null — cannot upload');
      }

      await ApiClient.postMultipart(
        '/auth/upload-cv',
        fields: {},
        fileField: 'cv',
        filePath: path,
        fileName: file.name,
        bytes: bytes,
      );
      await authCtrl.fetchProfile();
      cvCtrl.text = authCtrl.currentUser.value?.cvUrl ?? '';
      Get.snackbar(
        'CV Upload',
        'CV uploaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } catch (e) {
      debugPrint('[PersonalCv] Upload error: $e');
      Get.snackbar(
        'CV Upload',
        'Upload failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/Logo.png", width: 65, height: 65),
                SizedBox(width: 3),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Workscout",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: PersonalTitle(
                text: "Upload your CV to get analyzed and \n receive job offers.",
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  CustomTextForm(
                    mycontroller: cvCtrl,
                    valid: (val) => null,
                    readonly: true,
                    hinttext: "Upload your CV in pdf",
                    title: "CV",
                    suffixIcon: _isUploading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            onPressed: _pickAndUploadCV,
                            icon: const Icon(Icons.add_circle),
                          ),
                  ),
                  CustomTextForm(
                    valid: (val) => null,
                    hinttext: "URL Links",
                    title: "Protfoilo(opitional)",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  CustomCheckBox(
                    text: "I agree to the terms and conditions and privacy\npolicy of the application ",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            CustomButtonAuth(
              text: "Get Started",
              onPressed: () => Get.offAllNamed("/MainScreen"),
            ),
          ],
        ),
      ),
    );
  }
}
