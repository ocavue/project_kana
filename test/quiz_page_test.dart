import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_kana/quiz_cards.dart';
import 'package:project_kana/main.dart';

Future<void> goThroughQuizs(
  WidgetTester tester,
  Function(int) expectation,
) async {
  await tester.pumpWidget(App());
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  expectation(0);
  for (var index = 1; index <= 10; index++) {
    expectation(index);
    expect(find.byType(MyChip), findsWidgets);
    await tester.tap(find.byType(MyChip).first);
    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
  }
  expectation(11);
}

void main() {
  testWidgets('Quiz page smoke test', (WidgetTester tester) async {
    await goThroughQuizs(tester, (index) {});
  });

  testWidgets('Quiz cards number', (WidgetTester tester) async {
    final quizCardFinder = find.byType(Card);

    goThroughQuizs(
      tester,
      (index) {
        if (index <= 9)
          expect(quizCardFinder, findsNWidgets(2));
        else if (index == 10)
          expect(quizCardFinder, findsNWidgets(1));
        else
          expect(quizCardFinder, findsNWidgets(0));
      },
    );
  });
}
