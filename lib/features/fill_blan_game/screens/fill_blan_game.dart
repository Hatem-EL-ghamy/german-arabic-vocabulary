import 'dart:ui';
import 'package:flutter/material.dart';


class FillBlankGameScreen extends StatelessWidget {
  const FillBlankGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonScreen(title: 'املأ الفراغ');
  }
}

class WordRaceGameScreen extends StatelessWidget {
  const WordRaceGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonScreen(title: 'سباق الكلمات');
  }
}

// شاشة قريباً
class ComingSoonScreen extends StatelessWidget {
  final String title;

  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[600],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 100, color: Colors.orange[600]),
            SizedBox(height: 20),
            Text(
              'قريباً...',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange[600],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'هذا القسم تحت التطوير',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
