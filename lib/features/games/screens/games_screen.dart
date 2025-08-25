import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';
import 'package:hello_deutsch_app/features/fill_blan_game/screens/fill_blan_game.dart';
 

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الألعاب - Spiele',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.withOpacity(0.1), Colors.white],
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            GameCard(
              title: 'لعبة الذاكرة',
              germanTitle: 'Memory',
              icon: Icons.psychology,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGameScreen()),
                );
              },
            ),
            GameCard(
              title: 'اربط الكلمة',
              germanTitle: 'Match',
              icon: Icons.link,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchingGameScreen()),
                );
              },
            ),
            GameCard(
              title: 'املأ الفراغ',
              germanTitle: 'Fill Blank',
              icon: Icons.text_fields,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FillBlankGameScreen(),
                  ),
                );
              },
            ),
            GameCard(
              title: 'سباق الكلمات',
              germanTitle: 'Word Race',
              icon: Icons.speed,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordRaceGameScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// بطاقة اللعبة
class GameCard extends StatelessWidget {
  final String title;
  final String germanTitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.germanTitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              germanTitle,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// لعبة الذاكرة
class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<MemoryCard> cards = [];
  List<int> selectedCards = [];
  int matches = 0;
  int attempts = 0;
  bool isChecking = false;

  final List<LearningItem> gameItems = [
    LearningItem(
      arabic: 'كلب',
      german: 'Hund',
      pronunciation: 'هوند',
      emoji: '🐕',
    ),
    LearningItem(
      arabic: 'قطة',
      german: 'Katze',
      pronunciation: 'كاتسه',
      emoji: '🐱',
    ),
    LearningItem(
      arabic: 'أحمر',
      german: 'Rot',
      pronunciation: 'روت',
      emoji: '🔴',
    ),
    LearningItem(
      arabic: 'أزرق',
      german: 'Blau',
      pronunciation: 'بلاو',
      emoji: '🔵',
    ),
    LearningItem(
      arabic: 'تفاحة',
      german: 'Apfel',
      pronunciation: 'آبفل',
      emoji: '🍎',
    ),
    LearningItem(
      arabic: 'خبز',
      german: 'Brot',
      pronunciation: 'بروت',
      emoji: '🍞',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    cards.clear();
    for (int i = 0; i < gameItems.length; i++) {
      cards.add(
        MemoryCard(
          id: i * 2,
          content: gameItems[i].emoji,
          isMatched: false,
          isFlipped: false,
          matchId: i,
        ),
      );
      cards.add(
        MemoryCard(
          id: i * 2 + 1,
          content: gameItems[i].german,
          isMatched: false,
          isFlipped: false,
          matchId: i,
        ),
      );
    }
    cards.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'لعبة الذاكرة',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'المحاولات: $attempts',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Column(
          children: [
            if (matches == gameItems.length)
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'ممتاز! أكملت اللعبة في $attempts محاولة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _cardTapped(index),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: cards[index].isFlipped || cards[index].isMatched
                            ? Colors.white
                            : Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: cards[index].isFlipped || cards[index].isMatched
                            ? Text(
                                cards[index].content,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Icon(
                                Icons.help_outline,
                                color: Colors.white,
                                size: 30,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    matches = 0;
                    attempts = 0;
                    selectedCards.clear();
                    _initializeGame();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'لعبة جديدة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cardTapped(int index) {
    if (isChecking ||
        cards[index].isFlipped ||
        cards[index].isMatched ||
        selectedCards.length >= 2) {
      return;
    }

    setState(() {
      cards[index].isFlipped = true;
      selectedCards.add(index);
    });

    if (selectedCards.length == 2) {
      isChecking = true;
      attempts++;

      Future.delayed(Duration(milliseconds: 1000), () {
        _checkMatch();
      });
    }
  }

  void _checkMatch() {
    final card1 = cards[selectedCards[0]];
    final card2 = cards[selectedCards[1]];

    setState(() {
      if (card1.matchId == card2.matchId) {
        card1.isMatched = true;
        card2.isMatched = true;
        matches++;
      } else {
        card1.isFlipped = false;
        card2.isFlipped = false;
      }
      selectedCards.clear();
      isChecking = false;
    });
  }
}

// نموذج بيانات بطاقة الذاكرة
class MemoryCard {
  final int id;
  final String content;
  final int matchId;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.content,
    required this.matchId,
    this.isFlipped = false,
    this.isMatched = false,
  });
}

// لعبة الربط
class MatchingGameScreen extends StatefulWidget {
  const MatchingGameScreen({super.key});

  @override
  _MatchingGameScreenState createState() => _MatchingGameScreenState();
}

class _MatchingGameScreenState extends State<MatchingGameScreen> {
  List<String> leftItems = [];
  List<String> rightItems = [];
  List<String> matches = [];
  String? selectedLeft;
  String? selectedRight;
  int score = 0;

  final Map<String, String> correctMatches = {
    '🐕': 'Hund',
    '🐱': 'Katze',
    '🔴': 'Rot',
    '🔵': 'Blau',
    '🍎': 'Apfel',
    '🥛': 'Milch',
  };

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    leftItems = correctMatches.keys.toList()..shuffle();
    rightItems = correctMatches.values.toList()..shuffle();
    matches.clear();
    score = 0;
    selectedLeft = null;
    selectedRight = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اربط الكلمة',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Column(
          children: [
            if (matches.length == correctMatches.length)
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'رائع! أكملت جميع التطابقات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'اربط كل صورة بالكلمة الألمانية المناسبة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // العمود الأيسر (الصور)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: leftItems.length,
                      itemBuilder: (context, index) {
                        final item = leftItems[index];
                        final isMatched = matches.contains(item);
                        final isSelected = selectedLeft == item;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () {
                                  setState(() {
                                    selectedLeft = item;
                                    _checkMatch();
                                  });
                                },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? Colors.green[100]
                                  : isSelected
                                  ? Colors.blue[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isMatched
                                    ? Colors.green
                                    : isSelected
                                    ? Colors.blue
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(item, style: TextStyle(fontSize: 40)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // خط الوسط
                  Container(width: 2, color: Colors.grey[300]),

                  // العمود الأيمن (الكلمات)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: rightItems.length,
                      itemBuilder: (context, index) {
                        final item = rightItems[index];
                        final isMatched = matches.contains(
                          correctMatches.keys.firstWhere(
                            (key) => correctMatches[key] == item,
                            orElse: () => '',
                          ),
                        );
                        final isSelected = selectedRight == item;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () {
                                  setState(() {
                                    selectedRight = item;
                                    _checkMatch();
                                  });
                                },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? Colors.green[100]
                                  : isSelected
                                  ? Colors.blue[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isMatched
                                    ? Colors.green
                                    : isSelected
                                    ? Colors.blue
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                                textAlign: TextAlign.center,
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
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _initializeGame();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'لعبة جديدة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkMatch() {
    if (selectedLeft != null && selectedRight != null) {
      if (correctMatches[selectedLeft] == selectedRight) {
        setState(() {
          matches.add(selectedLeft!);
          score += 10;
          selectedLeft = null;
          selectedRight = null;
        });

        HapticFeedback.lightImpact();
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            selectedLeft = null;
            selectedRight = null;
          });
        });
      }
    }
  }
}
