import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/game_board.dart';
import '../lib/data/playable_category_registry.dart';

void main() {
  test('All 204 Two Pics clue images decode successfully', () async {
    for (var number = 1; number <= 102; number++) {
      for (var side = 1; side <= 2; side++) {
        final filename = 'assets/two_pics/redesign/${number.toString().padLeft(3, '0')}_$side.png';
        final bytes = await File(filename).readAsBytes();
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        expect(frame.image.width, greaterThan(0), reason: filename);
        expect(frame.image.height, greaterThan(0), reason: filename);
        frame.image.dispose();
        codec.dispose();
      }
    }
  });

  test('Playable category identifiers are unique and question banks are populated', () {
    expect(playableCategories, isNotEmpty);
    expect(playableCategories.map((c) => c.categoryId).toSet().length, playableCategories.length);
    for (final category in playableCategories) {
      expect(category.questions, isNotEmpty, reason: category.categoryId);
      expect(category.questions.map((q) => q.id).toSet().length, category.questions.length,
          reason: category.categoryId);
    }
  });

  test('Every playable category supplies 200/200/400/400/600/600', () {
    for (var i = 0; i < playableCategories.length; i++) {
      final slots = makeSlots(categoryForIndex(i));
      expect(slots.map((s) => s.points).toList(), [200, 200, 400, 400, 600, 600],
          reason: playableCategories[i].categoryId);
      expect(slots.map((s) => s.question.id).toSet().length, 6);
    }
  });

  for (final ar in [true, false]) {
    testWidgets('${ar ? 'Arabic' : 'English'} active question reveals its answer', (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final category = categoryForIndex(0);
      final slot = makeSlots(category).first;
      await tester.pumpWidget(MaterialApp(home: TimedQuestionScreen(
          ar: ar, slot: slot, primaryTeam: 0, teamA: 'A', teamB: 'B')));
      await tester.pump();
      final answer = ar ? slot.question.answerAr : slot.question.answerEn;
      expect(find.text(answer), findsNothing);
      await tester.tap(find.text(ar ? 'إظهار الإجابة' : 'Show answer'));
      await tester.pump();
      expect(find.text(answer), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Timeout transfers the question to the other team for 15 seconds', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final category = categoryForIndex(0);
    await tester.pumpWidget(MaterialApp(home: TimedQuestionScreen(
        ar: false, slot: makeSlots(category).first, primaryTeam: 0,
        teamA: 'A', teamB: 'B')));
    await tester.pump(const Duration(seconds: 60));
    expect(find.text('15'), findsOneWidget);
    expect(find.text('Time • B'), findsOneWidget);
    await tester.pump(const Duration(seconds: 15));
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Show answer'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
