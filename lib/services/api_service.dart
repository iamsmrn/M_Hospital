import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../models/xray_report.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:4000/reports';

  Future<List<XRayReport>> getReports() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:4000/reports/xray'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Data: $data");
      return data.map((json) => XRayReport.fromJson(json)).toList();
    }
    throw Exception('Failed to load reports');
  }

  Future<XRayReport> uploadReport(XFile image, {String? patientId}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:4000/reports/xray'));

    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );
    print("image: $image");

    if (patientId != null) request.fields['patientId'] = patientId;


    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: $responseData');

      if (response.statusCode == 201) {
        return XRayReport.fromJson(json.decode(responseData));
      } else {
        print('Unexpected Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
    throw Exception('Failed to upload report');
  }
}