import 'package:flutter/material.dart';
import 'package:circular_progress/src/pages/circular_progress_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularProgressPage()
    );
  }
}
