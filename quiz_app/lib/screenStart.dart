import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.startQuiz});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 200,
          color: const Color.fromARGB(250, 255, 255, 255),
        ),
        // Opacity(
        //   opacity: 0.7,
        //   child: Image.asset('assets/images/quiz-logo.png', width: 200),
        // ),
        const SizedBox(height: 30),
        Text(
          'Learn flutter the fun way !',
          style: GoogleFonts.lato(
            color: const Color.fromARGB(244, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          onPressed: startQuiz,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 30),
          ),
          icon: const Icon(Icons.arrow_right_alt, size: 40),
          label: const Text('Start Quiz'),
        ),
      ],
    );
  }
}
