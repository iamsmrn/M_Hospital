class ClinicalReport {
  final dynamic id;
  final String imageUrl;
  final dynamic date;
  final dynamic patientId;

  ClinicalReport({
    required this.id,
    required this.imageUrl,
    required this.date,
    this.patientId,
  });

  factory ClinicalReport.fromJson(Map<dynamic, dynamic> json) {
    return ClinicalReport(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      date: json['dateTaken'],
      patientId: json['patientId'],
    );
  }
}