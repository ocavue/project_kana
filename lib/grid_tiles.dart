import 'package:flutter/material.dart';

import 'kana.dart';
import 'kana_dialog.dart';

class EmptyGridTile extends StatelessWidget {
  final double gridSpacing;

  EmptyGridTile(this.gridSpacing) : super();

  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class KanaGridTile extends StatelessWidget {
  final double gridSpacing;
  final Kana kana;

  KanaGridTile(this.gridSpacing, this.kana) : super();

  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(kana.hiragana, style: TextStyle(fontSize: 24.0)),
                  Text(kana.katakana, style: TextStyle(fontSize: 24.0)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    kana.romaji,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text((kana.score * 10).toStringAsFixed(0)),
                ],
              ),
            ],
          ),
          onTap: () {
            KanaDialog(kana).show(context);
          },
        ),
      ),
    );
  }
}
