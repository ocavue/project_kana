import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildGridView() {
    List<Widget> gridCells = [];

    for (final kana in kanas) {
      final cell = InkWell(
        child: Container(
          child: Column(
            children: [
              Text(
                kana.hiragana,
                style: TextStyle(fontSize: 24.0),
              ),
              Row(
                children: [
                  Text(kana.katakana),
                  Text(kana.romaji),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
          ),
        ),
        onTap: () {
          print(kana);
        },
      );
      gridCells.add(cell);
    }

    return GridView.count(
      primary: false,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 5,
      children: gridCells,
      padding: EdgeInsets.only(bottom: 64), // Add padding for FAB
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Setting',
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute<void>(
                  builder: (BuildContext context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildGridView(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check),
        label: Text("Start Quiz"),
        onPressed: () {
          Navigator.of(context).push(
            new MaterialPageRoute<void>(
              builder: (BuildContext context) => QuizPage(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
