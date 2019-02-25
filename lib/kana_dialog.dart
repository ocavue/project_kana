import 'package:flutter/material.dart';

import 'kana.dart';

class KanaDialog extends StatelessWidget {
  final Kana kana;

  KanaDialog(this.kana) : super();

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 64.0), // Keep romaji at center
          Text(
            kana.romaji,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16.0),
          // Width of Icon is 48.0
          IconButton(
            iconSize: 22.0,
            color: Colors.grey[500],
            icon: Icon(Icons.volume_up),
            onPressed: kana.playAudio,
          ),
        ],
      ),
      titlePadding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
      contentPadding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('hiragana'),
              SizedBox(height: 8),
              Text(
                kana.hiragana,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ]),
            Column(children: [
              Text('katakana'),
              SizedBox(height: 8),
              Text(
                kana.katakana,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ]),
          ],
        )
      ],
    );
  }
}
