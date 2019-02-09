import 'package:flutter/material.dart';

import 'kana.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int correctIndex = 0;
  int choicedIndex;
  Kana targetKana;
  List<Kana> choicedKanas;
  List<String> choicedChars;

  @override
  Widget build(BuildContext context) {
    targetKana = kanas[0];
    choicedKanas = <Kana>[kanas[0], kanas[1], kanas[2], kanas[3]];
    choicedChars = choicedKanas.map((Kana kana) => kana.hiragana).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: Text('1 / 10'),
            ),
            Expanded(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          targetKana.katakana,
                          style: TextStyle(fontSize: 64.0),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildChoices(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChoices() {
    return List<Widget>.generate(
      choicedChars.length,
      (int index) {
        return Container(
          padding: EdgeInsets.only(top: 16.0),
          child: ChoiceChip(
            label: Text(
              choicedChars[index],
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 64.0),
            pressElevation: 0.0,
            selectedColor:
                correctIndex == index ? Colors.green[200] : Colors.red[200],
            selected: choicedIndex == index,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  choicedIndex = index;
                  submitAnswer();
                }
              });
            },
          ),
        );
      },
    ).toList();
  }

  void submitAnswer() {
    print(
      'submit index $choicedIndex (${correctIndex == choicedIndex ? "correct" : "incorrect"})',
    );
  }
}
