import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';
import '../lib/game_board.dart';
import '../lib/data/playable_category_registry.dart';

void main() {
  final manifest = jsonDecode(File('content/two_pics_redesign.json').readAsStringSync()) as Map<String,dynamic>;
  final replacements = (manifest['cards'] as List).cast<Map<String,dynamic>>()
      .where((c) => c['replacementRevision'] == 'flag-resolution-2026-10-09').toList();
  test('All 204 clue images decode successfully', () async {
    for (var number = 1; number <= 102; number++) {
      for (var side = 1; side <= 2; side++) {
        const prefix = 'assets/two_pics/redesign';
        const extension = 'png';
        final filename = '$prefix/${number.toString().padLeft(3, '0')}_$side.$extension';
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

  test('Every playable category supplies 200/200/400/400/600/600', () {
    for (var i = 0; i < playableCategories.length; i++) {
      final slots = makeSlots(categoryForIndex(i));
      expect(slots.map((s) => s.points).toList(), [200,200,400,400,600,600]);
      expect(slots.map((s) => s.question.id).toSet().length, 6);
    }
  });

  for (final ar in [true, false]) {
    for (final replacement in replacements) {
      testWidgets('${ar ? 'Arabic' : 'English'} rewritten pair ${replacement['id']} displays and reveals its reviewed answer', (tester) async {
        tester.view.physicalSize = const Size(1280,900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final index = playableCategories.indexWhere((c) => c.categoryId == 'two_pics');
        final category = categoryForIndex(index);
        final question = category.questions.singleWhere((q) => q.id == replacement['id']);
        final slot = BoardSlot(category:category,points:question.difficulty.points,question:question);
        await tester.pumpWidget(MaterialApp(home:TimedQuestionScreen(ar:ar,slot:slot,primaryTeam:0,teamA:'A',teamB:'B')));
        await tester.pumpAndSettle();
        final actual = tester.widgetList<Image>(find.byType(Image)).map((i)=>(i.image as AssetImage).assetName).toSet();
        final expected = (replacement['images'] as List).map((i)=>i['path'] as String).toSet();
        expect(actual,expected);
        final answer = replacement[ar?'answerAr':'answerEn'] as String;
        expect(find.text(answer),findsNothing);
        await tester.tap(find.text(ar?'إظهار الإجابة':'Show answer'));
        await tester.pump();
        expect(find.text(answer),findsOneWidget);
        expect(tester.takeException(),isNull);
      });
    }
    testWidgets('${ar ? 'Arabic' : 'English'} Two Pics uses both replacement assets', (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final index = playableCategories.indexWhere((c) => c.categoryId == 'two_pics');
      final category = categoryForIndex(index);
      final slot = makeSlots(category).first;
      await tester.pumpWidget(MaterialApp(home: TimedQuestionScreen(
        ar: ar, slot: slot, primaryTeam: 0, teamA: 'A', teamB: 'B')));
      await tester.pumpAndSettle();
      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(images.length, 2);
      for (final image in images) {
        expect((image.image as AssetImage).assetName, startsWith('assets/two_pics/redesign/'));
      }
      expect(find.text(ar ? slot.question.answerAr : slot.question.answerEn), findsNothing);
      await tester.tap(find.text(ar ? 'إظهار الإجابة' : 'Show answer'));
      await tester.pump();
      expect(find.text(ar ? slot.question.answerAr : slot.question.answerEn), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final ar in [true, false]) {
    testWidgets('${ar ? 'Arabic' : 'English'} selection and scoring', (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const TriviaGameApp());
      await tester.tap(find.text(ar ? 'العربية' : 'English'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(ar ? 'كوّن لعبتك' : 'Build your game'));
      await tester.pumpAndSettle();
      expect(find.text(ar ? 'الإمارات' : 'UAE'), findsOneWidget);
      await tester.tap(find.text(ar ? 'الإمارات' : 'UAE'));
      await tester.pump();
      await tester.tap(find.text(ar ? 'التالي • جهّز الفريقين' : 'Next • Set up teams'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'A');
      await tester.enterText(find.byType(TextField).at(1), 'B');
      await tester.tap(find.text(ar ? 'ابدأ المواجهة' : 'Start the showdown'));
      await tester.pumpAndSettle();
      expect(find.text('200'), findsNWidgets(2));
      expect(find.text('400'), findsNWidgets(2));
      expect(find.text('600'), findsNWidgets(2));
      await tester.tap(find.text('200').first);
      await tester.pumpAndSettle();
      expect(find.text('60'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('58'), findsOneWidget);
      await tester.tap(find.text(ar ? 'إظهار الإجابة' : 'Show answer'));
      await tester.pump();
      await tester.tap(find.widgetWithText(OutlinedButton, 'A'));
      await tester.pumpAndSettle();
      expect(find.text('A  200'), findsOneWidget);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Timeout transfers the question to the other team for 15 seconds', (tester) async {
    tester.view.physicalSize = const Size(1280,900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final category = categoryForIndex(0);
    await tester.pumpWidget(MaterialApp(home: TimedQuestionScreen(
      ar:false, slot:makeSlots(category).first, primaryTeam:0,
      teamA:'A',teamB:'B')));
    await tester.pump(const Duration(seconds:60));
    expect(find.text('15'), findsOneWidget);
    expect(find.text('Time • B'), findsOneWidget);
    await tester.pump(const Duration(seconds:15));
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Show answer'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
