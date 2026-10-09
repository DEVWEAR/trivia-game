import 'dart:io';
import '../lib/data/category_catalog.dart';
import '../lib/data/question_bank.dart';
import '../lib/data/question_bank_validation.dart';

void main(List<String> args) {
  final ids = <String>{};
  final errors = <String>[];
  if (triviaCategories.length != 50) errors.add('Catalog must contain 50 categories');
  if (triviaCategories.map((c) => c.id).toSet().length != triviaCategories.length) {
    errors.add('Duplicate category IDs');
  }
  final selected = args.isEmpty ? triviaCategories : triviaCategories.where((c) => args.contains(c.id));
  for (final id in args) {
    if (!triviaCategories.any((c) => c.id == id)) errors.add('Unknown category: $id');
  }
  for (final category in selected) {
    errors.addAll(validateQuestionBank(category.id, catalogQuestionBanks[category.id] ?? [], globalIds: ids));
  }
  for (final error in errors) { stderr.writeln(error); }
  stdout.writeln('${errors.length} validation issues. Factual/editorial review remains separate.');
  exitCode = errors.isEmpty ? 0 : 1;
}
