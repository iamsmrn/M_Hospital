import 'package:flutter/material.dart';
import 'main_app.dart';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
        primaryColor: const Color(0xFF00B894),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainApp(),
    );
  }
}