import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/quiz/screen/quiz_screen.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/learning_card/screens/llearning_carde.dart';
 

class LearningScreen extends StatefulWidget {
  final String title;
  final List<LearningItem> items;
  final Color backgroundColor;

  const LearningScreen({
    super.key,
    required this.title,
    required this.items,
    required this.backgroundColor,
  });

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: widget.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.quiz, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    items: widget.items,
                    title: widget.title,
                    backgroundColor: widget.backgroundColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.backgroundColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return LearningCard(
              item: widget.items[index],
              color: widget.backgroundColor,
            );
          },
        ),
      ),
    );
  }
}
