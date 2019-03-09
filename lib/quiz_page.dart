import 'dart:math';

import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz.dart';
import 'storage.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  int quizLength;
  List<Quiz> quizs = [];
  Map<Kana, double> scoresSnapshot = {};
  Widget result = Container();

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

  void _removeQuiz(VoidCallback delayedCallback) {
    // Wait for a while, so that user can ee if the answer is correct
    Future.delayed(const Duration(milliseconds: 100), () {
      // Tell the animation to start
      controller.forward().whenComplete(() {
        controller.reset();
        quizs.removeAt(0);
        delayedCallback();
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
    final kanaPool = kanas..shuffle();
    final choicedKanas = kanaPool.getRange(0, 4).toList();
    for (final kana in choicedKanas) scoresSnapshot[kana] = kana.score;

    assert(choicedKanas.length >= 4);

    for (final kana in choicedKanas) {
      final index = choicedKanas.indexOf(kana);

      List<Kana> wrongKanas = List<Kana>.from(choicedKanas)
        ..remove(kana)
        ..shuffle()
        ..getRange(0, 3).toList();
      wrongKanas = wrongKanas.getRange(0, 3).toList();
      assert(wrongKanas.length == 3);

      assert(wrongKanas.length == 3, "${wrongKanas.length}");

      final int randomType = Random().nextInt(2);
      String getKanaAttr(Kana kana) {
        if (randomType == 0) return kana.hiragana;
        if (randomType == 1) return kana.katakana;
        return kana.katakana;
      }

      final Quiz quiz = MultipleChoicesQuiz(
        question: kana.romaji,
        correctChoice: getKanaAttr(kana),
        wrongChoices: [
          getKanaAttr(wrongKanas[0]),
          getKanaAttr(wrongKanas[1]),
          getKanaAttr(wrongKanas[2]),
        ],
        onSubmit: (String selectedChoice) {
          setState(() {
            if (selectedChoice == getKanaAttr(kana)) {
              kana.score += 0.1;
            } else {
              kana.score = kana.score * 0.8;
            }
          });
          _removeQuiz(() {
            if (index + 1 == choicedKanas.length) {
              List<Widget> listTiles = [];
              for (final kana in choicedKanas) {
                listTiles.add(ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${kana.romaji}'),
                      Text(
                        '${(scoresSnapshot[kana] * 10).toStringAsFixed(0)} => ${(kana.score * 10).toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                ));
              }
              result = Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListView(children: listTiles, shrinkWrap: true),
                  RaisedButton(child: Text('OK'), onPressed: () {}),
                ],
              );
            }
          });
          kanaScoresStorage.saveSorces();
        },
      );

      quizs.add(quiz);
    }

    quizLength = quizs.length;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> stack = [];
    stack.addAll(quizs.reversed.map(
      (Quiz quiz) {
        return Transform.translate(
          offset: _getOffset(quiz),
          child: quizs.indexOf(quiz) <= 1 ? quiz : Container(),
        );
      },
    ));
    stack.add(result);

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
                children: stack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
