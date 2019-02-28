import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_kana/kana.dart';
import 'package:project_kana/kana_dialog.dart';

Future buildKanaDialog(WidgetTester tester, Kana kana) async {
  final dialog = KanaDialog(kana);
  await tester.pumpWidget(MaterialApp(home: Material(child: Builder(
    builder: (BuildContext context) {
      return RaisedButton(onPressed: () => dialog.show(context));
    },
  ))));
  await tester.tap(find.byType(RaisedButton));
  await tester.pump();
}

void main() {
  testWidgets('Romoji position', (WidgetTester tester) async {
    await buildKanaDialog(tester, kanas[0]);

    final dialogFinder = find.byType(KanaDialog);
    final romajiFinder = find.text(kanas[0].romaji);
    expect(dialogFinder, findsOneWidget);
    expect(romajiFinder, findsOneWidget);

    final double dialogLeft = tester.getTopLeft(dialogFinder).dx;
    final double dialogRight = tester.getTopRight(dialogFinder).dx;

    final double romajiLeft = tester.getTopLeft(romajiFinder).dx;
    final double romajiRight = tester.getTopRight(romajiFinder).dx;

    final double romojiLeftPadding = romajiLeft - dialogLeft;
    final double romojiRightPadding = dialogRight - romajiRight;

    // Make sure that romoji is at center
    expect(romojiLeftPadding - romojiRightPadding, 0.0);
  });
}
