import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int quizLength;
  List<Quiz> quizs;

  void _removeQuiz() {
    setState(() {
      quizs.removeAt(0);
    });
  }

  _QuizPageState() {
    quizs = [
      MultipleChoicesQuiz(
        question: kanas[0].katakana,
        correctChoice: 0,
        choices: [
          kanas[0].hiragana,
          kanas[1].hiragana,
          kanas[2].hiragana,
          kanas[3].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[4].katakana,
        correctChoice: 3,
        choices: [
          kanas[7].hiragana,
          kanas[6].hiragana,
          kanas[5].hiragana,
          kanas[4].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[6].katakana,
        correctChoice: 1,
        choices: [
          kanas[5].hiragana,
          kanas[6].hiragana,
          kanas[4].hiragana,
          kanas[7].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[7].katakana,
        correctChoice: 0,
        choices: [
          kanas[7].hiragana,
          kanas[8].hiragana,
          kanas[9].hiragana,
          kanas[10].hiragana,
        ],
        onSubmit: () => {},
      ),
    ];

    quizLength = quizs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: Text('${quizLength - quizs.length + 1} / $quizLength'),
            ),
            Expanded(
              child: Stack(children: quizs.reversed.toList()),
            )
          ],
        ),
      ),
    );
  }
}
