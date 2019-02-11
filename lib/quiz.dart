import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Quiz extends StatefulWidget {
  Quiz({Key key}) : super(key: key);
}

class MultipleChoicesQuiz extends Quiz {
  final List<String> choices;
  final String question;
  final int correctChoice;
  final VoidCallback onSubmit;

  MultipleChoicesQuiz({
    Key key,
    @required this.choices,
    @required this.question,
    @required this.correctChoice,
    @required this.onSubmit,
  })  : assert(correctChoice < choices.length),
        super(key: key);

  @override
  MultipleChoicesQuizState createState() => new MultipleChoicesQuizState();
}

class MultipleChoicesQuizState extends State<MultipleChoicesQuiz> {
  int selectIndex = -1;

  List<Widget> _buildChoices(BuildContext context) {
    return List<Widget>.generate(
      widget.choices.length,
      (int index) {
        final bool isCorrectChoice = widget.correctChoice == index;

        return Container(
          padding: EdgeInsets.only(top: 16.0),
          child: ChoiceChip(
            label: Text(
              widget.choices[index],
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 64.0),
            pressElevation: 0.0,
            selectedColor: isCorrectChoice ? Colors.green[200] : Colors.red[200],
            selected: selectIndex == index,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  selectIndex = index;
                  print(
                    'select ${widget.choices[index]}, ${isCorrectChoice ? 'correct' : 'incorrect'}',
                  );
                  widget.onSubmit();
                  print('called');
                }
              });
            },
          ),
        );
      },
    ).toList();
  }

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.question,
                style: TextStyle(fontSize: 64.0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChoices(context),
          ),
        ],
      ),
    );
  }
}
