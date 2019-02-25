import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz_page.dart';
import 'settings_page.dart';
import 'kana_dialog.dart';

const gridSpacing = 1.0;

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
      final cell = Container(
        child: Ink(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 0.0,
                spreadRadius: gridSpacing,
              )
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: InkWell(
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
            onTap: () {
              print(kana);
              final dialog = KanaDialog(kana);
              dialog.show(context);
            },
          ),
        ),
      );
      gridCells.add(cell);
    }

    return GridView.count(
      primary: false,
      crossAxisSpacing: gridSpacing,
      mainAxisSpacing: gridSpacing,
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
