import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<LearningItem> items;
  final String title;
  final Color backgroundColor;

  const QuizScreen({
    super.key,
    required this.items,
    required this.title,
    required this.backgroundColor,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= widget.items.length) {
      return _buildResultScreen();
    }

    final currentItem = widget.items[currentQuestionIndex];
    final options = _generateOptions(currentItem);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اختبار - ${widget.title}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: widget.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.backgroundColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // شريط التقدم
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / widget.items.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.backgroundColor,
                ),
              ),
              SizedBox(height: 20),

              // رقم السؤال
              Text(
                'السؤال ${currentQuestionIndex + 1} من ${widget.items.length}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),

              // السؤال
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.backgroundColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(currentItem.emoji, style: TextStyle(fontSize: 80)),
                    SizedBox(height: 20),
                    Text(
                      'ما معنى هذا بالألمانية؟',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // الخيارات
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    Color buttonColor = Colors.white;
                    Color textColor = widget.backgroundColor;

                    if (isAnswered) {
                      if (option == currentItem.german) {
                        buttonColor = Colors.green;
                        textColor = Colors.white;
                      } else if (option == selectedAnswer &&
                          option != currentItem.german) {
                        buttonColor = Colors.red;
                        textColor = Colors.white;
                      }
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: isAnswered
                            ? null
                            : () => _answerQuestion(option),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: isAnswered ? 0 : 4,
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _generateOptions(LearningItem correctItem) {
    final options = <String>[correctItem.german];
    final allItems = widget.items.where((item) => item != correctItem).toList();
    allItems.shuffle();

    while (options.length < 4 && allItems.isNotEmpty) {
      final randomItem = allItems.removeAt(0);
      if (!options.contains(randomItem.german)) {
        options.add(randomItem.german);
      }
    }

    // إذا لم نحصل على 4 خيارات، أضف خيارات إضافية
    while (options.length < 4) {
      options.add('خيار ${options.length}');
    }

    options.shuffle();
    return options;
  }

  void _answerQuestion(String answer) {
    setState(() {
      isAnswered = true;
      selectedAnswer = answer;
      if (answer == widget.items[currentQuestionIndex].german) {
        score++;
        HapticFeedback.lightImpact();
      } else {
        HapticFeedback.heavyImpact();
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          currentQuestionIndex++;
          isAnswered = false;
          selectedAnswer = '';
        });
      }
    });
  }

  Widget _buildResultScreen() {
    final percentage = (score / widget.items.length * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'النتيجة',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: widget.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.backgroundColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  percentage >= 80 ? Icons.emoji_events : Icons.thumb_up,
                  size: 100,
                  color: widget.backgroundColor,
                ),
                SizedBox(height: 30),
                Text(
                  percentage >= 80 ? 'ممتاز!' : 'أحسنت!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: widget.backgroundColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'نتيجتك: $score من ${widget.items.length}',
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: widget.backgroundColor,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'العودة للتعلم',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 