class Job {
  final String id;
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
    required this.id,
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
      id: json['_id'] ?? json['id'],
      companyName: json['companyName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      location: json['location'] ?? '',
      jobType: json['jobType'] ?? '',
      contractType: json['contractType'] ?? '',
      experienceLevel: json['experienceLevel'] ?? '',
      postedDate: json['postedDate'] ?? '',
      salary: json['salary'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      description: json['description'] ?? '',
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      requirements: List<String>.from(json['requirements'] ?? []),
      benefits: List<String>.from(json['benefits'] ?? []),
      officeAddress: json['officeAddress'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class Experience {
  String title;
  String company;
  String date;
  String logo;

  Experience({
    required this.title,
    required this.company,
    required this.date,
    this.logo = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      date: json['date'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'date': date,
      if (logo.isNotEmpty) 'logo': logo,
    };
  }
}

class Education {
  String degree;
  String university;
  String date;

  Education({
    required this.degree,
    required this.university,
    required this.date,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] ?? '',
      university: json['university'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'university': university,
      'date': date,
    };
  }
}

class UserProfile {
  String name;
  String position;
  String location;
  String profilePic;
  List<Experience> experiences;
  List<String> skills;
  List<String> languages;
  List<String> savedJobsIds;
  List<Education> education;
  String email;
  String cvUrl;

  UserProfile({
    required this.name,
    required this.position,
    required this.location,
    required this.profilePic,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.savedJobsIds,
    required this.education,
    this.email = '',
    this.cvUrl = '',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final rawExperiences = json['experiences'] as List<dynamic>?;
    final rawEducation = json['education'] as List<dynamic>?;

    return UserProfile(
      name: json['name'] ?? '',
      position: json['position'] ?? json['role'] ?? '',
      location: json['location'] ?? '',
      profilePic: json['profilePic'] ?? '',
      experiences: rawExperiences != null
          ? rawExperiences
              .map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      savedJobsIds: List<String>.from(json['savedJobsIds'] ?? []),
      education: rawEducation != null
          ? rawEducation
              .map((e) => Education.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      email: json['email'] ?? '',
      cvUrl: json['cvUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'location': location,
      'profilePic': profilePic,
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'skills': skills,
      'languages': languages,
      'savedJobsIds': savedJobsIds,
      'education': education.map((e) => e.toJson()).toList(),
      'email': email,
      'cvUrl': cvUrl,
    };
  }
}

class JobApplication {
  final Job job;
  String status;
  final String appliedDate;
  final String? adminMessage;

  JobApplication({
    required this.job,
    required this.status,
    required this.appliedDate,
    this.adminMessage,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    final jobData = json['job'] ?? json['jobId'];
    Job job;
    if (jobData is Map<String, dynamic>) {
      job = Job.fromJson(jobData);
    } else {
      job = Job.fromJson({'_id': json['jobId']?.toString() ?? ''});
    }
    return JobApplication(
      job: job,
      status: json['status'] ?? 'pending',
      appliedDate: json['appliedDate'] ?? json['appliedAt'] ?? '',
      adminMessage: json['adminMessage'],
    );
  }
}
