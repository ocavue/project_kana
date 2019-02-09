import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Kana',
      home: HomePage(title: 'Project Kana'),
    );
  }
}
