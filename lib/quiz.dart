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
        final Color selectedColor =
            isCorrectChoice ? Colors.green[200] : Colors.red[200];

        return Container(
          margin: EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
          width: 256,
          child: MyChip(
            shape: StadiumBorder(),
            child: Text(
              widget.choices[index],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            color: Colors.grey[300],
            selectedColor: selectedColor,
            selected: selectIndex == index,
            onSelected: () {
              if (selectIndex > -1) return;
              setState(() {
                selectIndex = index;
                print(
                  'select ${widget.choices[index]}, ${isCorrectChoice ? 'correct' : 'incorrect'}',
                );
                widget.onSubmit();
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
            children: _buildChoices(context),
          ),
        ],
      ),
    );
  }
}
