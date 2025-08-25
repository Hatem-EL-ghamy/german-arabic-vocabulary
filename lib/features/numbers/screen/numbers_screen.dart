import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning/screen/learning_screen.dart';

class NumbersScreen extends StatelessWidget {
  final List<LearningItem> numbers = [
    LearningItem(
      arabic: 'واحد',
      german: 'Eins',
      pronunciation: 'آينس',
      emoji: '1️⃣',
    ),
    LearningItem(
      arabic: 'اثنان',
      german: 'Zwei',
      pronunciation: 'تسفاي',
      emoji: '2️⃣',
    ),
    LearningItem(
      arabic: 'ثلاثة',
      german: 'Drei',
      pronunciation: 'درای',
      emoji: '3️⃣',
    ),
    LearningItem(
      arabic: 'أربعة',
      german: 'Vier',
      pronunciation: 'فير',
      emoji: '4️⃣',
    ),
    LearningItem(
      arabic: 'خمسة',
      german: 'Fünf',
      pronunciation: 'فونف',
      emoji: '5️⃣',
    ),
    LearningItem(
      arabic: 'ستة',
      german: 'Sechs',
      pronunciation: 'زكس',
      emoji: '6️⃣',
    ),
  ];

  NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningScreen(
      title: 'الأرقام - Zahlen',
      items: numbers,
      backgroundColor: Colors.purple,
    );
  }
}
