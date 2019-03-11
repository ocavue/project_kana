import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyChip extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color selectedColor;
  final VoidCallback onSelected;
  final bool selected;
  final ShapeBorder shape;

  MyChipState createState() => new MyChipState();

  MyChip({
    Key key,
    @required this.child,
    @required this.color,
    @required this.selectedColor,
    @required this.onSelected,
    @required this.selected,
    @required this.shape,
  }) : super(key: key);
}

class MyChipState extends State<MyChip> {
  Widget build(BuildContext context) {
    final color = widget.selected ? widget.selectedColor : widget.color;

    return Ink(
      decoration: ShapeDecoration(
        shape: widget.shape,
        color: color,
      ),
      child: InkWell(
        customBorder: widget.shape,
        onTap: widget.onSelected,
        child: Container(
          child: Center(child: widget.child),
          height: 48.0,
        ),
      ),
    );
  }
}

abstract class QuizCard extends StatefulWidget {
  QuizCard({Key key}) : super(key: key);
}

class MultipleChoicesQuiz extends QuizCard {
  final String question;
  final String correctChoice;
  final List<String> wrongChoices;
  final Function(String) onSubmit;

  MultipleChoicesQuiz({
    Key key,
    @required this.question,
    @required this.correctChoice,
    @required this.wrongChoices,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  MultipleChoicesQuizState createState() => new MultipleChoicesQuizState();
}

class MultipleChoicesQuizState extends State<MultipleChoicesQuiz> {
  List<String> shuffleChoices = [];
  String selectedChoice;

  Widget _buildChoice(String choice) {
    final bool isCorrect = widget.correctChoice == choice;
    final Color selectedColor = isCorrect ? Colors.green[200] : Colors.red[200];
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
      width: 256,
      child: MyChip(
        shape: StadiumBorder(),
        child: Text(
          choice,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        color: Colors.grey[300],
        selectedColor: selectedColor,
        selected: selectedChoice == choice,
        onSelected: () {
          if (selectedChoice != null && selectedChoice != choice) return;
          setState(() {
            selectedChoice = choice;
            print(
              'select $choice, ${isCorrect ? 'correct' : 'incorrect'}',
            );
            widget.onSubmit(selectedChoice);
          });
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    if (shuffleChoices.length == 0) {
      shuffleChoices.add(widget.correctChoice);
      shuffleChoices.addAll(widget.wrongChoices);
      shuffleChoices.shuffle();
    }

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: shuffleChoices.map(_buildChoice).toList(),
          ),
        ],
      ),
    );
  }
}
