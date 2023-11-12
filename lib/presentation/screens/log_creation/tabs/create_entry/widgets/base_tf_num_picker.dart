import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/typography.dart';

class BaseTFNumPicker extends StatelessWidget {
  const BaseTFNumPicker({
    Key? key,
    required this.title,
    required this.child,
    required this.onPressedLeftArrow,
    required this.onPressedRightArrow,
    required this.leftSubText,
    required this.rightSubText,
    required this.reachedZero,
    required this.width,
  }) : super(key: key);

  final String title;
  final Widget child;
  final VoidCallback onPressedLeftArrow;
  final VoidCallback onPressedRightArrow;
  final String leftSubText;
  final String rightSubText;
  final bool reachedZero;
  final double width;
  @override
  Widget build(BuildContext context) {
    final _sideFontSize = rightSubText.length > 4 ? 20 : 24;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StyledText.labelMedium(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onPressedLeftArrow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: reachedZero ? Colors.white : Colors.white30,
                        size: _sideFontSize.toDouble(),
                      ),
                    ),
                    Text(
                      leftSubText,
                      style: TextStyle(
                        fontSize: _sideFontSize.toDouble(),
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width,
                child: child,
              ),
              GestureDetector(
                onTap: onPressedRightArrow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rightSubText,
                      style: TextStyle(
                        fontSize: _sideFontSize.toDouble(),
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: _sideFontSize.toDouble(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
