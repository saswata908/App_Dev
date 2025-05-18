import 'package:flutter/material.dart';
import 'dart:math';

var randomizer = Random();

class Toss extends StatefulWidget {
  const Toss({super.key});
  @override
  State<Toss> createState() {
    return _TossState();
  }
}

class _TossState extends State<Toss> {
  var currPos = 1;
  void letsToss() {
    setState(() {
      currPos = randomizer.nextInt(2) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/coin-$currPos.png', width: 200),
        const SizedBox(height: 30),
        TextButton(
          onPressed: letsToss,
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.cyan,
            textStyle: const TextStyle(fontSize: 35),
          ),
          child: const Text('Toss'),
        ),
      ],
    );
  }
}
