// import 'package:flutter/material.dart';
// import 'package:workscout/data/model/job_model.dart';


// class ApplyJobPage extends StatefulWidget {
//   final Job job; // استقبال الوظيفة المختارة

//   const ApplyJobPage({super.key, required this.job});

//   @override
//   State<ApplyJobPage> createState() => _ApplyJobPageState();
// }

// class _ApplyJobPageState extends State<ApplyJobPage> {
//   final TextEditingController _coverLetterController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF334E58)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Apply",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             // كرت الوظيفة المختارة (Dynamic)
//             _buildJobSummaryCard(),
//             const SizedBox(height: 30),
//             const Text(
//               "Upload Your Resume",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             // كرت رفع السيرة الذاتية
//             _buildResumeUploadCard(),
//             const SizedBox(height: 15),
//             _buildSelectExistingLink(),
//             const SizedBox(height: 30),
//             const Text(
//               "Cover Later (Optional)",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             // حقل رسالة التغطية
//             _buildCoverLetterField(),
//             const SizedBox(height: 40),
//             // زر التقديم النهائي
//             _buildApplyButton(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // ملخص الوظيفة في أعلى الصفحة
//   Widget _buildJobSummaryCard() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60, height: 60,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 widget.job.companyLogo,
//                 errorBuilder: (c, e, s) => const Icon(Icons.business, size: 30),
//               ),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.job.companyName, style: const TextStyle(color: Colors.grey, fontSize: 13)),
//                 Text(widget.job.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 Text(widget.job.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // تصميم كرت الملف المرفوع
//   Widget _buildResumeUploadCard() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFF9F2), // لون خلفية بيج فاتح
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.orange.shade100),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text("CV UI Designer Eng.pdf", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("1.45 Mb - 23 Agu 2024 at 13:20 am", style: TextStyle(color: Colors.grey, fontSize: 11)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectExistingLink() {
//     return InkWell(
//       onTap: () {},
//       child: Row(
//         children: const [
//           Text("Select an existing resume", style: TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.w500)),
//           SizedBox(width: 5),
//           Icon(Icons.arrow_forward, size: 16, color: Color(0xFF334E58)),
//         ],
//       ),
//     );
//   }

//   Widget _buildCoverLetterField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         TextField(
//           controller: _coverLetterController,
//           maxLines: 8,
//           decoration: InputDecoration(
//             hintText: "Dear Hiring Manager...",
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade300)),
//             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade300)),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text("78/100", style: TextStyle(color: Colors.grey, fontSize: 12)),
//       ],
//     );
//   }

//   Widget _buildApplyButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         onPressed: () {
//           // هنا ستتم عملية الرفع لـ MongoDB لاحقاً
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Application Sent!")));
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF435B66),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//         child: const Text("Apply Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:workscout/controller/application_controller.dart';
import 'package:workscout/controller/auth_controller.dart';
import 'package:workscout/data/model/job_model.dart';

class ApplyJobPage extends StatefulWidget {
  final Job job;

  const ApplyJobPage({super.key, required this.job});

  @override
  State<ApplyJobPage> createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  final TextEditingController _coverLetterController = TextEditingController();
  late final AuthController authCtrl;

  String? _fileName;
  String? _fileSize;
  String? _selectedFilePath;
  List<int>? _selectedFileBytes;
  bool _isFileSelected = false;
  bool _isSubmitting = false;
  String? _storedCvUrl;
  bool _isReplacing = false;

  @override
  void initState() {
    super.initState();
    authCtrl = Get.find<AuthController>();
    final cvUrl = authCtrl.currentUser.value?.cvUrl ?? '';
    if (cvUrl.isNotEmpty) {
      _storedCvUrl = cvUrl;
      _fileName = cvUrl.split('/').last;
    }
  }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _fileName = file.name;
          _selectedFilePath = file.path;
          _selectedFileBytes = file.bytes;
          double sizeInMb = file.size / (1024 * 1024);
          _fileSize = "${sizeInMb.toStringAsFixed(2)} MB";
          _isFileSelected = true;
          _isReplacing = true;
        });
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  bool get _canSubmit =>
      !_isSubmitting &&
      (_isFileSelected || (_storedCvUrl != null && _storedCvUrl!.isNotEmpty)) &&
      _coverLetterController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF334E58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Apply",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // 1. كرت الوظيفة (Responsive)
            _buildJobSummaryCard(),
            
            const SizedBox(height: 30),
            const Text(
              "Upload Your Resume",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334E58)),
            ),
            const SizedBox(height: 15),
            
            // 2. قسم رفع الملف (التفاعلي)
            _buildResumeUploadSection(),
            
            const SizedBox(height: 15),
            _buildSelectExistingLink(),
            
            const SizedBox(height: 30),
            const Text(
              "Cover Letter (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334E58)),
            ),
            const SizedBox(height: 15),
            
            // 3. حقل رسالة التغطية
            _buildCoverLetterField(),
            
            const SizedBox(height: 40),
            
            // 4. زر التقديم النهائي
            _buildApplyButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ملخص الوظيفة بناءً على الوظيفة الممررة
  Widget _buildJobSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.job.companyLogo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, size: 30, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.job.companyName,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 2),
                Text(widget.job.jobTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 2),
                Text(widget.job.location,
                    style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeUploadSection() {
    final hasStoredCV = _storedCvUrl != null && _storedCvUrl!.isNotEmpty && !_isReplacing;

    if (hasStoredCV) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FFF0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green.shade200, width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _fileName ?? "CV from profile",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "From your profile",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _pickPDF,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9F2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _isFileSelected ? Colors.orange.shade200 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isFileSelected ? _fileName! : "Click to select your CV",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isFileSelected ? "$_fileSize - Just now" : "PDF format only",
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            if (_isFileSelected)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectExistingLink() {
    final hasStoredCV = _storedCvUrl != null && _storedCvUrl!.isNotEmpty && !_isReplacing;
    return InkWell(
      onTap: hasStoredCV && !_isReplacing ? () => setState(() => _isReplacing = true) : _pickPDF,
      child: Row(
        children: [
          Text(
            hasStoredCV ? "Replace CV" : "Select an existing resume",
            style: const TextStyle(color: Color(0xFF334E58), fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF334E58)),
        ],
      ),
    );
  }

  Widget _buildCoverLetterField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _coverLetterController,
          maxLines: 7,
          onChanged: (val) => setState(() {}), // لتحديث العداد
          decoration: InputDecoration(
            hintText: "Explain why you are the best fit for this role...",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${_coverLetterController.text.length}/500",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
Widget _buildApplyButton() {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: _canSubmit
        ? () async {
            setState(() => _isSubmitting = true);
            try {
              final appCtrl = Get.find<ApplicationController>();
              await appCtrl.apply(
                jobId: widget.job.id,
                filePath: _isFileSelected ? _selectedFilePath : null,
                fileName: _isFileSelected ? _fileName : null,
                coverLetter: _coverLetterController.text,
                cvUrl: (!_isFileSelected && _storedCvUrl != null) ? _storedCvUrl! : '',
                bytes: _isFileSelected ? _selectedFileBytes : null,
              );
            } finally {
              if (mounted) setState(() => _isSubmitting = false);
            }
          }
        : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF435B66),
        disabledBackgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _isSubmitting
        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
        : const Text(
            "Apply Now",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
    ),
  );
}
}