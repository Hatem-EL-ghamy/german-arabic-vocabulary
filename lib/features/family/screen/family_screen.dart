import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning/screen/learning_screen.dart';
 

class FamilyScreen extends StatelessWidget {
  final List<LearningItem> family = [
    LearningItem(arabic: 'أب', german: 'Vater', pronunciation: 'فاتر', emoji: '👨'),
    LearningItem(arabic: 'أم', german: 'Mutter', pronunciation: 'موتر', emoji: '👩'),
    LearningItem(arabic: 'ولد', german: 'Junge', pronunciation: 'يونگه', emoji: '👦'),
    LearningItem(arabic: 'بنت', german: 'Mädchen', pronunciation: 'ميدشن', emoji: '👧'),
    LearningItem(arabic: 'أخ', german: 'Bruder', pronunciation: 'برودر', emoji: '👨‍🦱'),
    LearningItem(arabic: 'أخت', german: 'Schwester', pronunciation: 'شفستر', emoji: '👩‍🦱'),
  ];

  FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningScreen(
      title: 'العائلة - Familie',
      items: family,
      backgroundColor: Colors.blue,
    );
  }
}
