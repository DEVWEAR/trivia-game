import 'dart:math';
import 'package:flutter/material.dart';
import 'data/question_model.dart';
import 'data/questions/uae_general_final.dart';
import 'data/questions/uae_football_final.dart';

void main() => runApp(const TriviaGameApp());

class TriviaGameApp extends StatefulWidget {
  const TriviaGameApp({super.key});
  @override
  State<TriviaGameApp> createState() => _TriviaGameAppState();
}

class _TriviaGameAppState extends State<TriviaGameApp> {
  Locale? locale;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080A14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF775BFF),
          brightness: Brightness.dark,
        ),
      ),
      home: locale == null
          ? LanguageGate(onSelected: (v) => setState(() => locale = v))
          : HomeScreen(
              locale: locale!,
              changeLanguage: () => setState(() => locale = null),
            ),
    );
  }
}

class LanguageGate extends StatelessWidget {
  const LanguageGate({super.key, required this.onSelected});
  final ValueChanged<Locale> onSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF775BFF), Color(0xFF23D7CF)],
                  ),
                ),
                child: const Icon(Icons.bolt_rounded, size: 54),
              ),
              const SizedBox(height: 28),
              const Text(
                'اختر لغتك  •  Choose your language',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 36),
              LanguageCard(
                flag: '🇦🇪',
                title: 'العربية',
                subtitle: 'ابدأ اللعب بالعربي',
                tap: () => onSelected(const Locale('ar')),
              ),
              const SizedBox(height: 14),
              LanguageCard(
                flag: '🇬🇧',
                title: 'English',
                subtitle: 'Play in English',
                tap: () => onSelected(const Locale('en')),
              ),
              const Spacer(),
              const Text('200  •  400  •  600'),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.tap,
  });
  final String flag, title, subtitle;
  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: card(),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 34)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.locale, required this.changeLanguage});
  final Locale locale;
  final VoidCallback changeLanguage;

  @override
  Widget build(BuildContext context) {
    final ar = locale.languageCode == 'ar';
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(ar ? 'جاهز للتحدي؟' : 'Ready to challenge?'),
          actions: [IconButton(onPressed: changeLanguage, icon: const Icon(Icons.language_rounded))],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(colors: [Color(0xFF6C4DFF), Color(0xFF241B60)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ar ? 'أول لعبة علينا 🎁' : 'Your first game is on us 🎁',
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(ar ? 'كل لعبة تختار لك أسئلة بترتيب مختلف.' : 'Every game draws questions in a different random order.'),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(ar: ar))),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(ar ? 'كوّن لعبتك' : 'Build your game'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(ar ? 'الفئات الجاهزة' : 'Ready categories', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                CategoryMini('🇦🇪', ar ? 'الإمارات' : 'UAE'),
                CategoryMini('⚽', ar ? 'كرة القدم الإماراتية' : 'UAE Football'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.ar});
  final bool ar;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final selected = <int>{};
  final cats = const [
    ['🇦🇪', 'الإمارات', 'UAE'],
    ['⚽', 'كرة القدم الإماراتية', 'UAE Football'],
  ];

  @override
  Widget build(BuildContext context) {
    final ar = widget.ar;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, title: Text(ar ? 'اصنع المواجهة' : 'Build the showdown')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ar ? 'اختر من فئة إلى 6 فئات' : 'Choose 1 to 6 categories', style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  Text(ar ? '${selected.length}/6 مختارة • اختر العدد اللي يناسب لعبتكم' : '${selected.length}/6 selected • choose as many as you want', style: const TextStyle(color: Colors.white60)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.12,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: cats.length,
                itemBuilder: (_, i) {
                  final on = selected.contains(i);
                  final c = cats[i];
                  return InkWell(
                    onTap: () => setState(() {
                      if (on) {
                        selected.remove(i);
                      } else if (selected.length < 6) {
                        selected.add(i);
                      }
                    }),
                    borderRadius: BorderRadius.circular(24),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: on ? const Color(0xFF6D52E8).withValues(alpha: .30) : Colors.white.withValues(alpha: .05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: on ? const Color(0xFF8E7AFF) : Colors.white10, width: on ? 2 : 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c[0], style: const TextStyle(fontSize: 30)),
                              if (on) const Icon(Icons.check_circle_rounded, color: Color(0xFF8FE8DF)),
                            ],
                          ),
                          const Spacer(),
                          Text(ar ? c[1] : c[2], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(ar ? '102 سؤال' : '102 questions', style: const TextStyle(color: Color(0xFF8FE8DF), fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              for (final p in ['200', '400', '600'])
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsetsDirectional.only(end: 4),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .06), borderRadius: BorderRadius.circular(8)),
                                    child: Text(p, style: const TextStyle(fontSize: 10)),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: selected.isNotEmpty
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => TeamSetup(ar: ar, selectedCategoryIndexes: selected.toList())),
                            )
                        : null,
                    child: Text(ar ? 'التالي • جهّز الفريقين' : 'Next • Set up teams', style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamSetup extends StatefulWidget {
  const TeamSetup({super.key, required this.ar, required this.selectedCategoryIndexes});
  final bool ar;
  final List<int> selectedCategoryIndexes;
  @override
  State<TeamSetup> createState() => _TeamSetupState();
}

class _TeamSetupState extends State<TeamSetup> {
  final a = TextEditingController();
  final b = TextEditingController();

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ar = widget.ar;
    final count = widget.selectedCategoryIndexes.length;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ar ? 'سمّوا الفريقين' : 'Name your teams', style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
              const SizedBox(height: 30),
              TeamField(controller: a, icon: '⚡', label: ar ? 'الفريق الأول' : 'Team One'),
              const SizedBox(height: 14),
              TeamField(controller: b, icon: '🔥', label: ar ? 'الفريق الثاني' : 'Team Two'),
              const Spacer(),
              Text(
                ar ? '${count * 6} سؤال • $count فئات • سؤالان من كل مستوى لكل فئة' : '${count * 6} questions • $count categories • two from each level per category',
                style: const TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: () {
                    final qs = buildGameQuestions(widget.selectedCategoryIndexes);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameScreen(
                          ar: ar,
                          questions: qs,
                          teamA: a.text.trim().isEmpty ? (ar ? 'الفريق الأول' : 'Team One') : a.text.trim(),
                          teamB: b.text.trim().isEmpty ? (ar ? 'الفريق الثاني' : 'Team Two') : b.text.trim(),
                        ),
                      ),
                    );
                  },
                  child: Text(ar ? 'ابدأ المواجهة' : 'Start the showdown', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<TriviaQuestion> buildGameQuestions(List<int> selected) {
  final result = <TriviaQuestion>[];
  for (final i in selected) {
    final pool = i == 0 ? uaeGeneralFinalQuestions : uaeFootballFinalQuestions;
    for (final d in QuestionDifficulty.values) {
      final candidates = pool.where((q) => q.difficulty == d).toList()..shuffle(Random.secure());
      result.addAll(candidates.take(2));
    }
  }
  result.shuffle(Random.secure());
  return result;
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.ar, required this.questions, required this.teamA, required this.teamB});
  final bool ar;
  final List<TriviaQuestion> questions;
  final String teamA, teamB;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int index = 0;
  int scoreA = 0;
  int scoreB = 0;
  bool revealed = false;
  int turn = 0;

  @override
  Widget build(BuildContext context) {
    final ar = widget.ar;
    if (widget.questions.isEmpty) {
      return Scaffold(body: Center(child: Text(ar ? 'لا توجد أسئلة متاحة' : 'No questions available')));
    }
    final q = widget.questions[index];
    final points = q.difficulty.points;
    final last = index == widget.questions.length - 1;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, title: Text('${index + 1}/${widget.questions.length}')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: ScoreCard(name: widget.teamA, score: scoreA, active: turn == 0)),
                    const SizedBox(width: 10),
                    Expanded(child: ScoreCard(name: widget.teamB, score: scoreB, active: turn == 1)),
                  ],
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: card(),
                  child: Text('$points', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF8FE8DF))),
                ),
                const Spacer(),
                Text(ar ? q.questionAr : q.questionEn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, height: 1.4)),
                const SizedBox(height: 30),
                if (revealed)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(color: const Color(0xFF6D52E8).withValues(alpha: .22), borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      children: [
                        Text(ar ? 'الإجابة' : 'Answer', style: const TextStyle(color: Colors.white60)),
                        const SizedBox(height: 8),
                        Text(ar ? q.answerAr : q.answerEn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                const Spacer(),
                if (!revealed)
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(onPressed: () => setState(() => revealed = true), child: Text(ar ? 'إظهار الإجابة' : 'Show answer')),
                  )
                else
                  Row(
                    children: [
                      Expanded(child: FilledButton.tonal(onPressed: () => next(false, last), child: Text(ar ? 'خطأ' : 'Wrong'))),
                      const SizedBox(width: 10),
                      Expanded(child: FilledButton(onPressed: () => next(true, last), child: Text(ar ? 'صحيح +$points' : 'Correct +$points'))),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void next(bool correct, bool last) {
    if (correct) {
      if (turn == 0) {
        scoreA += widget.questions[index].difficulty.points;
      } else {
        scoreB += widget.questions[index].difficulty.points;
      }
    }
    if (last) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(ar: widget.ar, a: widget.teamA, b: widget.teamB, sa: scoreA, sb: scoreB),
        ),
      );
      return;
    }
    setState(() {
      index++;
      revealed = false;
      turn = 1 - turn;
    });
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.ar, required this.a, required this.b, required this.sa, required this.sb});
  final bool ar;
  final String a, b;
  final int sa, sb;

  @override
  Widget build(BuildContext context) {
    final draw = sa == sb;
    final winner = sa > sb ? a : b;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 70)),
                const SizedBox(height: 20),
                Text(
                  draw ? (ar ? 'تعادل!' : 'It’s a draw!') : (ar ? 'الفائز: $winner' : 'Winner: $winner'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 30),
                Text('$a  $sa  —  $sb  $b', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 40),
                FilledButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: Text(ar ? 'العودة للرئيسية' : 'Back home')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.name, required this.score, required this.active});
  final String name;
  final int score;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF6D52E8).withValues(alpha: .30) : Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: active ? const Color(0xFF8E7AFF) : Colors.white10),
      ),
      child: Column(
        children: [
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text('$score', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class TeamField extends StatelessWidget {
  const TeamField({super.key, required this.controller, required this.icon, required this.label});
  final TextEditingController controller;
  final String icon, label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Center(widthFactor: 1.5, child: Text(icon, style: const TextStyle(fontSize: 25))),
        labelText: label,
        filled: true,
        fillColor: Colors.white.withValues(alpha: .05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      ),
    );
  }
}

class CategoryMini extends StatelessWidget {
  const CategoryMini(this.e, this.t, {super.key});
  final String e, t;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(15),
      decoration: card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e, style: const TextStyle(fontSize: 27)),
          const SizedBox(height: 8),
          Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          const Text('102', style: TextStyle(color: Color(0xFF8FE8DF))),
        ],
      ),
    );
  }
}

BoxDecoration card() => BoxDecoration(
      color: Colors.white.withValues(alpha: .055),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: .09)),
    );
