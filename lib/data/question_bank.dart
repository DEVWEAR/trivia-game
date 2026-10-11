import 'question_model.dart';
import 'playable_category_registry.dart';

/// The current playable catalog. Draft categories are added here only after
/// their question files exist and they are registered for gameplay.
final catalogQuestionBanks = <String, List<TriviaQuestion>>{
  for (final category in playableCategories)
    category.categoryId: category.questions,
};
