class XRayReport {
  final dynamic id;
  final String imageUrl;
  final dynamic date;
  final dynamic patientId;

  XRayReport({
    required this.id,
    required this.imageUrl,
    required this.date,
    this.patientId,
  });

  factory XRayReport.fromJson(Map<dynamic, dynamic> json) {
    return XRayReport(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      date: json['dateTaken'],
      patientId: json['patientId'],
    );
  }
}