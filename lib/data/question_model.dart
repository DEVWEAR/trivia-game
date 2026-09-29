enum QuestionDifficulty {
  easy200(200),
  medium400(400),
  hard600(600);

  const QuestionDifficulty(this.points);
  final int points;
}

enum QuestionMediaType { none, image, audio, video }

class TriviaQuestion {
  const TriviaQuestion({
    required this.id,
    required this.categoryId,
    required this.difficulty,
    required this.questionAr,
    required this.questionEn,
    required this.answerAr,
    required this.answerEn,
    required this.sourceName,
    required this.sourceUrl,
    required this.lastVerified,
    this.mediaType = QuestionMediaType.none,
    this.mediaAsset,
    this.mediaAsset2,
  });

  final String id;
  final String categoryId;
  final QuestionDifficulty difficulty;
  final String questionAr;
  final String questionEn;
  final String answerAr;
  final String answerEn;

  /// Verification is mandatory before a question can enter production.
  final String sourceName;
  final String sourceUrl;
  final DateTime lastVerified;

  final QuestionMediaType mediaType;
  final String? mediaAsset;

  /// Optional second image for visual puzzle formats such as Two Pics One Word.
  /// Both assets must be real/licensed photographic images, not emoji stand-ins.
  final String? mediaAsset2;
}

/// Production content rules:
/// 1. Every question has a globally unique ID.
/// 2. categoryId must match exactly one category in category_catalog.dart.
/// 3. Arabic and English versions must ask the same fact.
/// 4. Answer must be verified from a reliable source before publishing.
/// 5. Difficulty is always 200, 400, or 600.
/// 6. No question is reused for the same account after it is shown.
/// 7. Image/audio/video assets must be owned, licensed, or otherwise safe to use.
/// 8. Time-sensitive facts must have a lastVerified date and be reviewed again.
/// 9. A question never moves into a loosely related category just to fill quota.
/// 10. Question count and remaining count are maintained independently per category.
/// 11. Two Pics One Word uses two real photographic assets; the pair must lead fairly and logically to the answer.
