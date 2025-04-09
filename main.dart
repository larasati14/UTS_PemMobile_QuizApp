import 'package:flutter/material.dart';
import './screens/home_screen.dart'; // pastiin ini ada
// ignore: unused_import
import './screens/quiz_screen.dart';
//ignore: unused_import
import './data/sample_questions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // wajib super.key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // harus ada HomePage
    );
  }
}
