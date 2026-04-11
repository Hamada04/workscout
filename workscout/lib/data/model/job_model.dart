// // model.dart
// class Job {
//   final String companyName;
//   final String jobTitle;
//   final String location;
//   final String jobType;
//   final String contractType;
//   final String experienceLevel;
//   final String postedDate;

//   Job({
//     required this.companyName,
//     required this.jobTitle,
//     required this.location,
//     required this.jobType,
//     required this.contractType,
//     required this.experienceLevel,
//     required this.postedDate,
//   });

//   // من أجل تحويل البيانات من JSON إلى موديل
//   factory Job.fromJson(Map<String, dynamic> json) {
//     return Job(
//       companyName: json['companyName'],
//       jobTitle: json['jobTitle'],
//       location: json['location'],
//       jobType: json['jobType'],
//       contractType: json['contractType'],
//       experienceLevel: json['experienceLevel'],
//       postedDate: json['postedDate'],
//     );
//   }
// }


// class Job {
//   final String companyName;
//   final String jobTitle;
//   final String location;
//   final String jobType;
//   final String contractType;
//   final String experienceLevel;
//   final String postedDate;
//   final String salary;
//   final String companyLogo;
//   final List<String> skills;
//   final String description;
//   final List<String> responsibilities;
//   final List<String> requirements;
//   final List<String> benefits;
//   final String officeAddress;
//   final String category; // الحقل الجديد للفلترة

//   Job({
//     required this.companyName,
//     required this.jobTitle,
//     required this.location,
//     required this.jobType,
//     required this.contractType,
//     required this.experienceLevel,
//     required this.postedDate,
//     required this.salary,
//     required this.companyLogo,
//     required this.skills,
//     required this.description,
//     required this.responsibilities,
//     required this.requirements,
//     required this.benefits,
//     required this.officeAddress,
//     required this.category, // تحديث الـ Constructor
//   });

//   factory Job.fromJson(Map<String, dynamic> json) {
//     return Job(
//       companyName: json['companyName'],
//       jobTitle: json['jobTitle'],
//       location: json['location'],
//       jobType: json['jobType'],
//       contractType: json['contractType'],
//       experienceLevel: json['experienceLevel'],
//       postedDate: json['postedDate'],
//       salary: json['salary'],
//       companyLogo: json['companyLogo'],
//       skills: List<String>.from(json['skills']),
//       description: json['description'],
//       responsibilities: List<String>.from(json['responsibilities']),
//       requirements: List<String>.from(json['requirements']),
//       benefits: List<String>.from(json['benefits']),
//       officeAddress: json['officeAddress'],
//       category: json['category'], // تحديث الـ Factory
//     );
//   }
// }

// job_model.dart

// 1. موديل الوظيفة (Job Model)
class Job {
  final String id; // حقل المعرف الفريد الضروري للباك آند
  final String companyName;
  final String jobTitle;
  final String location;
  final String jobType;
  final String contractType;
  final String experienceLevel;
  final String postedDate;
  final String salary;
  final String companyLogo;
  final List<String> skills;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> benefits;
  final String officeAddress;
  final String category;

  Job({
    required this.id, // تم إضافة الـ ID هنا
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.jobType,
    required this.contractType,
    required this.experienceLevel,
    required this.postedDate,
    required this.salary,
    required this.companyLogo,
    required this.skills,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.benefits,
    required this.officeAddress,
    required this.category,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'] ?? json['id'], // في MongoDB المعرف يكون غالباً باسم _id
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      location: json['location'],
      jobType: json['jobType'],
      contractType: json['contractType'],
      experienceLevel: json['experienceLevel'],
      postedDate: json['postedDate'],
      salary: json['salary'],
      companyLogo: json['companyLogo'],
      skills: List<String>.from(json['skills']),
      description: json['description'],
      responsibilities: List<String>.from(json['responsibilities']),
      requirements: List<String>.from(json['requirements']),
      benefits: List<String>.from(json['benefits']),
      officeAddress: json['officeAddress'],
      category: json['category'],
    );
  }
}

// 2. موديل الخبرات (Experience Model) لصفحة البروفايل
class Experience {
  final String title;
  final String company;
  final String date;
  final String logo;

  Experience({
    required this.title,
    required this.company,
    required this.date,
    required this.logo,
  });
}

// 3. موديل المستخدم (UserProfile Model)
// class UserProfile {
//   final String name;
//   final String position;
//   final String location;
//   final String profilePic;
//   final List<Experience> experiences;
//   final List<String> skills;
//   final List<String> languages;
//   final List<String> savedJobsIds; // قائمة تحتوي على الـ IDs للوظائف المحفوظة
//   List<Education> education;

//   UserProfile({
//     required this.name,
//     required this.position,
//     required this.location,
//     required this.profilePic,
//     required this.experiences,
//     required this.skills,
//     required this.languages,
//     required this.savedJobsIds,
//     required this.education
//   });
// }
// 3. موديل المستخدم (UserProfile Model) المحدث
class UserProfile {
  String name;        // أزلنا كلمة final لنتمكن من تعديلها
  String position;    // أزلنا كلمة final
  String location;    // أزلنا كلمة final
  String profilePic;  // أزلنا كلمة final
  List<Experience> experiences;
  List<String> skills;
  List<String> languages;
  List<String> savedJobsIds; 
  List<Education> education; // أضفنا هذا الحقل

  UserProfile({
    required this.name,
    required this.position,
    required this.location,
    required this.profilePic,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.savedJobsIds,
    required this.education, // تأكد أنه مطلوب هنا
  });
}

// 4. موديل طلب التوظيف (Job Application Model)
class JobApplication {
  final Job job; // الوظيفة التي تم التقديم عليها
  String status; // الحالات: 'Submitted', 'Interview', 'Accepted', 'Rejected'
  final String appliedDate;
  final String? adminMessage; // الرسالة الحقيقية من صاحب العمل (الأدمن)

  JobApplication({
    required this.job,
    required this.status,
    required this.appliedDate,
    this.adminMessage,
  });
}
// أضف هذا الموديل في ملف job_model.dart
class Education {
  String degree;
  String university;
  String level;
  String date;
  Education({required this.degree, required this.university, required this.level, required this.date});
}

// وتأكد أن UserProfile يحتوي على:
// List<Education> education;