import 'package:flutter/material.dart';
import 'package:coin_app/image_button.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer.pre({super.key})
    : color1 = Colors.yellow,
      color2 = Colors.green;

  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: Toss()),
    );
  }
}
