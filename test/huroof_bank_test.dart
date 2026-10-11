import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_game/huroof_questions_150.dart';
import 'package:trivia_game/data/question_model.dart';

void main() {
  test('Letters Challenge has 150 unique, complete questions', () {
    expect(huroofQuestions.length, 150);
    expect(huroofQuestions.map((q) => q.id).toSet().length, 150);
    for (final q in huroofQuestions) {
      expect(q.categoryId, 'huroof');
      expect(q.questionAr.trim(), isNotEmpty);
      expect(q.answerAr.trim(), isNotEmpty);
    }
  });

  test('Each difficulty has 50 questions', () {
    for (final difficulty in QuestionDifficulty.values) {
      expect(huroofQuestions.where((q) => q.difficulty == difficulty).length, 50);
    }
  });

  test('No repeated Arabic question text', () {
    final questions = huroofQuestions.map((q) => q.questionAr.trim()).toList();
    expect(questions.toSet().length, questions.length);
  });
}
