import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/splash/screen/splash_screen.dart';

void main() {
  runApp(GermanLearningApp());
}

class GermanLearningApp extends StatelessWidget {
  const GermanLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تعلم الألمانية',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
