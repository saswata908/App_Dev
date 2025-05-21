import 'package:flutter/material.dart';
import 'package:adv_basics/screenStart.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/results_screen.dart';

class QuizStart extends StatefulWidget {
  const QuizStart({super.key});
  @override
  State<QuizStart> createState() {
    return _QuizStartState();
  }
}

class _QuizStartState extends State<QuizStart> {
  List<String> selectedAnswers = [];
  // Widget? activeScreen;
  var activeScreen = 'start-screen';

  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }
  void getAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-Screen';
    });
  }

  void restarttQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(startQuiz: switchScreen);
    if (activeScreen == 'questions-Screen') {
      screenWidget = QuestionScreen(onSelectedAns: getAnswer);
    }
    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chosenAns: selectedAnswers,
        restartQuiz: restarttQuiz,
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(child: screenWidget),
        ),
      ),
    );
  }
}
