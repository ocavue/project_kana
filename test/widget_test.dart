// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_kana/main.dart';
import 'package:project_kana/kana.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    expect(find.text(kanas[0].hiragana), findsOneWidget);
    expect(find.text(kanas[4].hiragana), findsOneWidget);
    expect(find.text('settings'), findsNothing);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(find.text(kanas[0].hiragana), findsNothing);
    expect(find.text(kanas[4].hiragana), findsNothing);
    expect(find.text('Settings'), findsOneWidget);
  });
}
