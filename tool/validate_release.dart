import 'dart:io';
import '../lib/data/playable_category_registry.dart';
import '../lib/data/question_bank_validation.dart';
import '../lib/data/question_model.dart';

const certifiedCategories = <String>{
  'uae_football', 'uae_general', 'uae_heritage', 'gulf_culture',
  'kuwait_general', 'saudi_general', 'uae_pro_league', 'premier_league',
  'la_liga', 'serie_a', 'bundesliga', 'ligue_1', 'ucl', 'world_cup',
  'football_legends', 'emirati_music', 'gulf_music', 'kuwaiti_music',
  'saudi_music', 'egyptian_music', 'arabic_music', 'international_music',
  'old_school_music',
};

void main() {
  final errors = <String>[];
  final seenCategories = <String>{};
  final ids = <String>{};
  var certifiedQuestions = 0;
  for (final category in playableCategories) {
    if (!seenCategories.add(category.categoryId)) {
      errors.add('Duplicate playable category ${category.categoryId}');
    }
    if (certifiedCategories.contains(category.categoryId)) {
      errors.addAll(validateQuestionBank(category.categoryId,
          category.questions));
      certifiedQuestions += category.questions.length;
    }
    // Preserve existing legacy modes; do not label them as certified 204 banks.
    for (final tier in QuestionDifficulty.values) {
      if (category.questions.where((q) => q.difficulty == tier).length < 2) {
        errors.add('${category.categoryId}: cannot supply two ${tier.points} slots');
      }
    }
    for (final question in category.questions) {
      if (!ids.add(question.id)) errors.add('Duplicate playable ID ${question.id}');
      if (question.categoryId != category.categoryId) {
        errors.add('${question.id}: wrong playable category');
      }
      if ([question.questionAr, question.questionEn,
          question.answerAr, question.answerEn].any((s) => s.trim().isEmpty)) {
        errors.add('${question.id}: empty bilingual field');
      }
      for (final asset in [question.mediaAsset, question.mediaAsset2]) {
        if (asset != null && !asset.startsWith('http') && !File(asset).existsSync()) {
          errors.add('${question.id}: missing image $asset');
        }
      }
    }
  }
  if (!seenCategories.containsAll(certifiedCategories) ||
      certifiedQuestions != 4692) {
    errors.add('Release must include all 23 certified categories / 4692 questions');
  }
  for (final error in errors) { stderr.writeln(error); }
  stdout.writeln('Certified categories: ${certifiedCategories.length}; '
      'certified questions: $certifiedQuestions; '
      'playable categories: ${playableCategories.length}; '
      'release issues: ${errors.length}');
  exitCode = errors.isEmpty ? 0 : 1;
}
