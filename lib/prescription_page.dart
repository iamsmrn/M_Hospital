import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/precption.dart';
import '../services/api_service.dart';

class PrecptionPage extends StatefulWidget {
  @override
  _PrecptionPageState createState() => _PrecptionPageState();
}

class _PrecptionPageState extends State<PrecptionPage> {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  List<PrecptionPage> reports = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => isLoading = true);
    try {
      final data = await _apiService.getReports();
      print("datadata: $data");
      setState(() => reports = data.cast<PrecptionPage>());
    } catch (e) {
      print("getError: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading reports')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    try {
      await _apiService.uploadReport(image);
      _loadReports();
    } catch (e) {
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('X-Ray Reports'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    report.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Date: ${DateTime.parse(report.date).toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}