import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning/screen/learning_screen.dart';
 

class ColorsScreen extends StatelessWidget {
  final List<LearningItem> colors = [
    LearningItem(arabic: 'أحمر', german: 'Rot', pronunciation: 'روت', emoji: '🔴'),
    LearningItem(arabic: 'أزرق', german: 'Blau', pronunciation: 'بلاو', emoji: '🔵'),
    LearningItem(arabic: 'أخضر', german: 'Grün', pronunciation: 'گرین', emoji: '🟢'),
    LearningItem(arabic: 'أصفر', german: 'Gelb', pronunciation: 'گلب', emoji: '🟡'),
    LearningItem(arabic: 'أبيض', german: 'Weiß', pronunciation: 'فايس', emoji: '⚪'),
    LearningItem(arabic: 'أسود', german: 'Schwarz', pronunciation: 'شفارتس', emoji: '⚫'),
  ];

  ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningScreen(
      title: 'الألوان - Farben',
      items: colors,
      backgroundColor: Colors.pink,
    );
  }
}