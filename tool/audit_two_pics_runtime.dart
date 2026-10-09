import 'dart:convert';
import 'dart:io';
import '../lib/data/playable_category_registry.dart';
import 'validate_release.dart' show certifiedCategories;

String normalize(String text) => text.toLowerCase()
    .replaceAll(RegExp(r'[\u064b-\u065f\u0670]'), '')
    .replaceAll(RegExp(r'[^a-z0-9\u0600-\u06ff]+'), ' ').trim();

void main() {
  final m = jsonDecode(File('content/two_pics_redesign.json').readAsStringSync()) as Map<String,dynamic>;
  final cards = (m['cards'] as List).cast<Map<String,dynamic>>();
  final bank = playableCategories.singleWhere((c) => c.categoryId == 'two_pics');
  final errors = <String>[];
  final crossCandidates = <Map<String,String>>[];
  final ids = <String>{}, arAnswers = <String>{}, enAnswers = <String>{};
  for (final q in bank.questions) {
    final c = cards.singleWhere((c) => c['id'] == q.id);
    if (!ids.add(q.id)) errors.add('Duplicate ID ${q.id}');
    if (!arAnswers.add(normalize(q.answerAr))) errors.add('Duplicate Arabic answer ${q.id}');
    if (!enAnswers.add(normalize(q.answerEn))) errors.add('Duplicate English answer ${q.id}');
    if (q.categoryId != 'two_pics' || q.difficulty.points != c['points']) errors.add('Wrong category/tier ${q.id}');
    if (q.answerAr != c['answerAr'] || q.answerEn != c['answerEn']) errors.add('Runtime answer differs from reviewed manifest ${q.id}');
    final images = c['images'] as List;
    if (q.mediaAsset != images[0]['path'] || q.mediaAsset2 != images[1]['path']) errors.add('Runtime image mismatch ${q.id}');
    if ([q.questionAr,q.questionEn,q.answerAr,q.answerEn,q.sourceName,q.sourceUrl].any((s) => s.trim().isEmpty)) errors.add('Missing field ${q.id}');
    if (c['replacementRevision'] != null) {
      for (final category in playableCategories.where((c) => certifiedCategories.contains(c.categoryId))) {
        for (final old in category.questions) {
          if (normalize(old.answerAr) == normalize(q.answerAr) || normalize(old.answerEn) == normalize(q.answerEn) ||
              normalize(old.questionEn).contains(normalize(q.answerEn)) || normalize(old.questionAr).contains(normalize(q.answerAr))) {
            crossCandidates.add({'newId':q.id,'otherId':old.id,'questionEn':old.questionEn,'answerEn':old.answerEn});
          }
        }
      }
    }
  }
  if (bank.questions.length != 102) errors.add('Expected the existing 102-card Two Pics schema');
  final result = {'status':errors.isEmpty?'PASS':'FAIL','runtimeCards':bank.questions.length,'errors':errors,
    'protectedQuestionsCompared':playableCategories.where((c) => certifiedCategories.contains(c.categoryId)).fold<int>(0,(n,c)=>n+c.questions.length),
    'crossBankCandidates':crossCandidates,
    'instructionTextPolicy':'Shared Two Pics instruction is not a duplicate puzzle; identity is the answer concept and distinct ordered image pair.'};
  stdout.writeln(const JsonEncoder.withIndent('  ').convert(result));
  if (errors.isNotEmpty) exitCode=1;
}
