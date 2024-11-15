import 'package:flutter/material.dart';

class AnimatedGradientCircle extends StatefulWidget {
  @override
  _AnimatedGradientCircleState createState() => _AnimatedGradientCircleState();
}

class _AnimatedGradientCircleState extends State<AnimatedGradientCircle> {
  final List<Color> _colors = [
    Colors.deepPurple.shade400,
    Colors.purpleAccent.shade200,
    Colors.indigo.shade300,
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  // Start the animation of changing colors
  void _startColorAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _colors.length;
      });
      _startColorAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _colors[_currentIndex],
            _colors[(_currentIndex + 1) % _colors.length],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
