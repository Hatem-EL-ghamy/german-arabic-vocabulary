import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning/screen/learning_screen.dart';
 

class FoodScreen extends StatelessWidget {
  final List<LearningItem> food = [
    LearningItem(arabic: 'تفاحة', german: 'Apfel', pronunciation: 'آبفل', emoji: '🍎'),
    LearningItem(arabic: 'خبز', german: 'Brot', pronunciation: 'بروت', emoji: '🍞'),
    LearningItem(arabic: 'ماء', german: 'Wasser', pronunciation: 'فاسر', emoji: '💧'),
    LearningItem(arabic: 'حليب', german: 'Milch', pronunciation: 'ميلش', emoji: '🥛'),
    LearningItem(arabic: 'كعكة', german: 'Kuchen', pronunciation: 'كوخن', emoji: '🍰'),
    LearningItem(arabic: 'بيضة', german: 'Ei', pronunciation: 'آي', emoji: '🥚'),
  ];

  FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningScreen(
      title: 'الطعام - Essen',
      items: food,
      backgroundColor: Colors.orange,
    );
  }
}
