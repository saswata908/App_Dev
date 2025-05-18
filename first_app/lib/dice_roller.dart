import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;
  // var activeDiceImage = 'assets/images/dice-5.png';

  // void rollDice() {
  //   var diceRoll = Random().nextInt(6) + 1;
  //   setState(() {
  //     activeDiceImage = 'assets/images/dice-$diceRoll.png';
  //   });
  // }

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$currentDiceRoll.png', width: 170),
        const SizedBox(height: 35),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            //padding: const EdgeInsets.only(top: 29),
            backgroundColor: const Color.fromARGB(255, 183, 25, 167),
            foregroundColor: Colors.cyan,
            textStyle: const TextStyle(fontSize: 35),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
