class OfferLetterModel {
  final String id;
  final String position;
  final String salary;
  final String startDate;
  final String department;
  final String message;
  final String status;
  final String expiresAt;
  final String createdAt;

  OfferLetterModel({
    required this.id,
    required this.position,
    required this.salary,
    required this.startDate,
    required this.department,
    required this.message,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
  });

  factory OfferLetterModel.fromJson(Map<String, dynamic> json) {
    return OfferLetterModel(
      id: json['_id'] ?? '',
      position: json['position'] ?? '',
      salary: json['salary'] ?? '',
      startDate: json['startDate'] ?? '',
      department: json['department'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? 'sent',
      expiresAt: json['expiresAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
