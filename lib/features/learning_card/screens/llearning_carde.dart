import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_deutsch_app/features/home/screen/home_screen.dart';

class LearningCard extends StatefulWidget {
  final LearningItem item;
  final Color color;

  const LearningCard({super.key, required this.item, required this.color});

  @override
  _LearningCardState createState() => _LearningCardState();
}

class _LearningCardState extends State<LearningCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.only(bottom: 16),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(_isPressed ? 0.1 : 0.2),
              blurRadius: _isPressed ? 4 : 8,
              offset: Offset(0, _isPressed ? 1 : 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Text(widget.item.emoji, style: TextStyle(fontSize: 40)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.german,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.item.arabic,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 4),
              Text(
                widget.item.pronunciation,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.volume_up, color: widget.color, size: 30),
            onPressed: () {
              HapticFeedback.lightImpact();
              // هنا يمكن إضافة وظيفة النطق مستقبلاً
            },
          ),
        ),
      ),
    );
  }
}
