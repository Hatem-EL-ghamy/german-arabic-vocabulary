import 'package:flutter/material.dart';
import 'package:hello_deutsch_app/features/games/screens/games_screen.dart';
import 'package:hello_deutsch_app/features/foods/screens/foods_screen.dart';
import 'package:hello_deutsch_app/features/family/screen/family_screen.dart';
import 'package:hello_deutsch_app/features/colors/screens/colors_screen.dart';
import 'package:hello_deutsch_app/features/numbers/screen/numbers_screen.dart';
import 'package:hello_deutsch_app/features/animals/screen/animals_screen.dart';
import 'package:hello_deutsch_app/features/fill_blan_game/screens/fill_blan_game.dart';
 

class HomeScreen extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'الحيوانات',
      germanTitle: 'Tiere',
      icon: Icons.pets,
      color: Colors.green,
      route: 'animals',
    ),
    CategoryItem(
      title: 'العائلة',
      germanTitle: 'Familie',
      icon: Icons.family_restroom,
      color: Colors.blue,
      route: 'family',
    ),
    CategoryItem(
      title: 'الأرقام',
      germanTitle: 'Zahlen',
      icon: Icons.format_list_numbered,
      color: Colors.purple,
      route: 'numbers',
    ),
    CategoryItem(
      title: 'الألوان',
      germanTitle: 'Farben',
      icon: Icons.color_lens,
      color: Colors.pink,
      route: 'colors',
    ),
    CategoryItem(
      title: 'الطعام',
      germanTitle: 'Essen',
      icon: Icons.restaurant,
      color: Colors.orange,
      route: 'food',
    ),
    CategoryItem(
      title: 'الألعاب',
      germanTitle: 'Spiele',
      icon: Icons.games,
      color: Colors.red,
      route: 'games',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعلم الألمانية',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[600],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[100]!, Colors.yellow[50]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'مرحباً بك!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اختر قسماً لتبدأ التعلم',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                      onTap: () {
                        _navigateToCategory(context, categories[index].route);
                      },
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

  void _navigateToCategory(BuildContext context, String route) {
    Widget screen;
    switch (route) {
      case 'animals':
        screen = AnimalsScreen();
        break;
      case 'family':
        screen = FamilyScreen();
        break;
      case 'numbers':
        screen = NumbersScreen();
        break;
      case 'colors':
        screen = ColorsScreen();
        break;
      case 'food':
        screen = FoodScreen();
        break;
      case 'games':
        screen = GamesScreen();
        break;
      default:
        screen = ComingSoonScreen(title: route);
    }

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => screen)
    );
  }
}

// نموذج البيانات للأقسام
class CategoryItem {
  final String title;
  final String germanTitle;
  final IconData icon;
  final Color color;
  final String route;

  CategoryItem({
    required this.title,
    required this.germanTitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

// بطاقة القسم
class CategoryCard extends StatefulWidget {
  final CategoryItem category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.category.color.withOpacity(0.3),
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
                    decoration: BoxDecoration(
                      color: widget.category.color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.category.icon, 
                      size: 30, 
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.category.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.category.germanTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.category.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// نموذج البيانات للتعلم
class LearningItem {
  final String arabic;
  final String german;
  final String pronunciation;
  final String emoji;

  LearningItem({
    required this.arabic,
    required this.german,
    required this.pronunciation,
    required this.emoji,
  });
}
