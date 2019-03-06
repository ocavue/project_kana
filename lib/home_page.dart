import 'package:flutter/material.dart';

import 'kana.dart';
import 'quiz_page.dart';
import 'settings_page.dart';
import 'grid_tiles.dart';

const gridSpacing = 1.0;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _getKanaTiles() {
    final List<Widget> tiles = [];
    for (final kana in kanas) tiles.add(KanaGridTile(gridSpacing, kana));
    final emptyTile = EmptyGridTile(gridSpacing);
    for (final index in [31, 33, 41, 42, 43]) tiles.insert(index, emptyTile);
    return tiles;
  }

  Widget _buildGridView() {
    return GridView.count(
      primary: false,
      crossAxisSpacing: gridSpacing,
      mainAxisSpacing: gridSpacing,
      crossAxisCount: 5,
      children: _getKanaTiles(),
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
