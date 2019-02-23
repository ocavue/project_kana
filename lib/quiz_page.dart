import 'dart:math';

import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  int quizLength;
  List<Quiz> quizs;

  AnimationController controller;
  Animation<double> animation;
  double screenWidth;

  @override
  initState() {
    super.initState();
    // Because this class has now mixed in a TickerProvider
    // It can be its own vsync. This is what you need almost always
    controller = new AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ));

    // It will call the callback passed to it everytime the
    // value of the tween changes. Call setState within it
    // to repaint the widget with the new valueƒ
    animation.addListener(() {
      setState(() {});
    });
  }

  void _removeQuiz() {
    // Wait for a while, so that user can ee if the answer is correct
    Future.delayed(const Duration(milliseconds: 1000), () {
      // Tell the animation to start
      controller.forward().whenComplete(() {
        controller.reset();
        quizs.removeAt(0);
      });
    });
  }

  Offset _getOffset(Quiz quiz) {
    if (quizs.indexOf(quiz) == 0) {
      return Offset(-1 * screenWidth * animation.value, 0.0);
    }
    return Offset(0.0, 0.0);
  }

  _QuizPageState() {
    quizs = [
      MultipleChoicesQuiz(
        question: kanas[0].katakana,
        correctChoice: kanas[0].hiragana,
        wrongChoices: [
          kanas[1].hiragana,
          kanas[2].hiragana,
          kanas[3].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[4].katakana,
        correctChoice: kanas[4].hiragana,
        wrongChoices: [
          kanas[7].hiragana,
          kanas[6].hiragana,
          kanas[5].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[6].katakana,
        correctChoice: kanas[6].hiragana,
        wrongChoices: [
          kanas[5].hiragana,
          kanas[4].hiragana,
          kanas[7].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
      MultipleChoicesQuiz(
        question: kanas[7].katakana,
        correctChoice: kanas[7].hiragana,
        wrongChoices: [
          kanas[8].hiragana,
          kanas[9].hiragana,
          kanas[10].hiragana,
        ],
        onSubmit: _removeQuiz,
      ),
    ];

    quizLength = quizs.length;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: Text(
                '${min(quizLength - quizs.length + 1, quizLength)} / $quizLength',
              ),
            ),
            Expanded(
              child: Stack(
                children: quizs.reversed.map(
                  (quiz) {
                    return Transform.translate(
                      offset: _getOffset(quiz),
                      child: quiz,
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
