import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/question_model.dart';
import 'huroof_questions_150.dart';

/// Ten-letter hint mode. The first written character of EVERY answer word
/// is highlighted, including the definite article (e.g. نهر النيل => ن، ا).
class HuroofScreen extends StatefulWidget {
  const HuroofScreen({super.key, required this.ar});
  final bool ar;
  @override State<HuroofScreen> createState() => _HuroofScreenState();
}

class _HuroofScreenState extends State<HuroofScreen> {
  static const gold = Color(0xFFC99A58);
  static const bg = Color(0xFF211A20);
  static const panel = Color(0xFF302327);
  static const alphabet = 'ابتثجحخدذرزسشصضطظعغفقكلمنهوي';
  final random = Random();
  late final List<TriviaQuestion> pool;
  final Set<String> used = {};
  TriviaQuestion? current;
  List<String> letters = [];
  Set<String> hints = {};
  bool revealed = false;

  @override void initState() {
    super.initState();
    pool = huroofQuestions;
    _restoreProgress();
  }

  Future<void> _restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    used.addAll(prefs.getStringList('huroof_used_questions_v1') ?? const <String>[]);
    _next();
  }

  Future<void> _resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('huroof_used_questions_v1');
    if (!mounted) return;
    used.clear();
    _next();
  }

  String _normalize(String s) {
    if ('أإآٱ'.contains(s)) return 'ا';
    if (s == 'ى') return 'ي';
    if (s == 'ة') return 'ه';
    return s;
  }

  Set<String> _initials(String answer) {
    final words = answer.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    final out = <String>{};
    for (final word in words) {
      final letters = word.replaceAll(RegExp(r'[^ء-ي]'), '');
      if (letters.isNotEmpty) {
        final c = _normalize(letters.substring(0, 1));
        if (alphabet.contains(c)) out.add(c);
      }
    }
    return out;
  }

  void _next() {
    final remaining = pool.where((q) => !used.contains(q.id)).toList();
    if (remaining.isEmpty) {
      setState(() { current = null; letters = []; hints = {}; });
      return;
    }
    final q = remaining[random.nextInt(remaining.length)];
    final required = _initials(q.answerAr);
    // Never discard a required hint, even for a multiword answer.
    final chosen = required.toList();
    final fillers = alphabet.split('')..removeWhere(required.contains);
    fillers.shuffle(random);
    chosen.addAll(fillers.take(max(0, 10 - chosen.length)));
    chosen.shuffle(random);
    setState(() {
      current = q;
      letters = chosen;
      hints = required;
      revealed = false;
      used.add(q.id);
    });
    SharedPreferences.getInstance().then((prefs) => prefs.setStringList('huroof_used_questions_v1', used.toList()));
  }

  @override Widget build(BuildContext context) {
    final q = current;
    return Directionality(
      textDirection: widget.ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(title: Text(widget.ar ? 'تحدي الحروف' : 'Letter Challenge')),
        body: SafeArea(child: q == null
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('انتهت الأسئلة المتاحة'),
              const SizedBox(height: 16),
              FilledButton(onPressed: _resetProgress, child: const Text('العب من جديد')),
            ]))
          : LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Center(child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(widget.ar ? 'السؤال ${used.length}' : 'Question ${used.length}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text('${q.difficulty.points}', style: const TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.w900)),
                  ]),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(minHeight: 155),
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(24), border: Border.all(color: gold.withValues(alpha: .3))),
                    child: Text(widget.ar ? q.questionAr : q.questionEn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, height: 1.4)),
                  ),
                  const SizedBox(height: 22),
                  Text(widget.ar ? 'تلميح: أول حرف من كل كلمة في الإجابة' : 'Hint: First letter of each Arabic answer word', textAlign: TextAlign.center, style: const TextStyle(color: gold, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 9, mainAxisSpacing: 9, childAspectRatio: 1.25),
                    itemCount: letters.length,
                    itemBuilder: (_, i) {
                      final letter = letters[i];
                      final active = hints.contains(letter);
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? gold : panel,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: active ? const Color(0xFFF2D18C) : Colors.white24),
                        ),
                        child: Text(letter, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: active ? bg : Colors.white)),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  if (revealed) Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18)),
                    child: Column(children: [
                      Text(widget.ar ? 'الإجابة الصحيحة' : 'Correct answer', style: const TextStyle(color: gold, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(widget.ar ? q.answerAr : q.answerEn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: revealed ? _next : () => setState(() => revealed = true),
                    child: Padding(padding: const EdgeInsets.all(10), child: Text(revealed ? (widget.ar ? 'السؤال التالي' : 'Next question') : (widget.ar ? 'إظهار الإجابة' : 'Reveal answer'))),
                  ),
                ]),
              )),
            ))),
      ),
    );
  }
}
