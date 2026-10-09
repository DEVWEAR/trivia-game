import 'dart:io';
import '../lib/data/category_catalog.dart';
import '../lib/data/question_bank.dart';
import '../lib/data/question_model.dart';
import '../lib/data/question_bank_validation.dart';

void main() {
  final text = StringBuffer('# Question bank progress\n\n');
  text.writeln('Runtime inventory. Evidence, bilingual parity and difficulty review are pending; no category is certified COMPLETE.\n');
  text.writeln('| Category | Total | 200 | 400 | 600 | Verification | Structural validation |');
  text.writeln('|---|---:|---:|---:|---:|---|---|');
  final ids = <String>{};
  for (final category in triviaCategories) {
    final bank = catalogQuestionBanks[category.id] ?? <TriviaQuestion>[];
    final counts = QuestionDifficulty.values.map((d) => bank.where((q) => q.difficulty == d).length).toList();
    final errors = validateQuestionBank(category.id, bank, globalIds: ids);
    text.writeln('| ${category.ar} / ${category.en} | ${bank.length} | ${counts[0]} | ${counts[1]} | ${counts[2]} | Pending | ${errors.isEmpty ? 'PASS; editorial review pending' : 'FAIL (${errors.length} issues)'} |');
  }
  text.writeln('\nUAE Football must complete all review stages before category 2 begins. Run dart run tool/validate_question_bank.dart.');
  File('QUESTION_BANK_PROGRESS.md').writeAsStringSync(text.toString());
}
