import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning/screen/learning_screen.dart';
 

class AnimalsScreen extends StatelessWidget {
  final List<LearningItem> animals = [
    LearningItem(arabic: 'كلب', german: 'Hund', pronunciation: 'هوند', emoji: '🐕'),
    LearningItem(arabic: 'قطة', german: 'Katze', pronunciation: 'كاتسه', emoji: '🐱'),
    LearningItem(arabic: 'طائر', german: 'Vogel', pronunciation: 'فوگل', emoji: '🐦'),
    LearningItem(arabic: 'سمكة', german: 'Fisch', pronunciation: 'فيش', emoji: '🐠'),
    LearningItem(arabic: 'حصان', german: 'Pferd', pronunciation: 'فيرد', emoji: '🐴'),
    LearningItem(arabic: 'فيل', german: 'Elefant', pronunciation: 'إليفانت', emoji: '🐘'),
  ];

  AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningScreen(
      title: 'الحيوانات - Tiere',
      items: animals,
      backgroundColor: Colors.green,
    );
  }
}
