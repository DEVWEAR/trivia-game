import 'dart:math';
import 'dart:async';
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
  Timer? timer;
  int seconds = 60;
  bool steal = false;
  int startingTeam = 0;
  int scoreA = 0, scoreB = 0;
  QuestionDifficulty selectedDifficulty = QuestionDifficulty.easy200;
  bool loading = true;
  bool clockFinished = false;
  int? award;
  String teamA = 'الفريق الأول', teamB = 'الفريق الثاني';

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  void _startTimer(int value) {
    timer?.cancel();
    seconds = value;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      if (seconds > 1) { setState(() => seconds--); return; }
      t.cancel();
      if (!steal) {
        setState(() { steal = true; seconds = 15; });
        _startTimer(15);
      } else {
        setState(() { seconds = 0; clockFinished = true; });
      }
    });
  }

  void _reveal() { timer?.cancel(); setState(() => revealed = true); }

  void _beginSteal() {
    if (revealed || steal) return;
    setState(() { steal = true; clockFinished = false; seconds = 15; });
    _startTimer(15);
  }

  Future<void> _editTeams() async {
    final first = TextEditingController(text: teamA);
    final second = TextEditingController(text: teamB);
    try {
      final updated = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(widget.ar ? 'أسماء الفريقين' : 'Team names'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: first, maxLength: 24, decoration: InputDecoration(labelText: widget.ar ? 'الفريق الأول' : 'Team one')),
            TextField(controller: second, maxLength: 24, decoration: InputDecoration(labelText: widget.ar ? 'الفريق الثاني' : 'Team two')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(widget.ar ? 'إلغاء' : 'Cancel')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(widget.ar ? 'حفظ' : 'Save')),
          ],
        ),
      );
      if (!mounted || updated != true) return;
      setState(() {
        if (first.text.trim().isNotEmpty) teamA = first.text.trim();
        if (second.text.trim().isNotEmpty) teamB = second.text.trim();
      });
    } finally {
      first.dispose();
      second.dispose();
    }
  }

  void _confirmAward() {
    if (award == null || current == null) return;
    setState(() {
      if (award == 0) scoreA += current!.difficulty.points;
      if (award == 1) scoreB += current!.difficulty.points;
      startingTeam = 1 - startingTeam;
    });
    _next();
  }


  @override void initState() {
    super.initState();
    pool = huroofQuestions;
    _restoreProgress();
  }

  Future<void> _restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    loading = false;
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
    final remaining = pool.where((q) => !used.contains(q.id) && q.difficulty == selectedDifficulty).toList();
    if (remaining.isEmpty) {
      timer?.cancel();
      setState(() { current = null; letters = []; hints = {}; });
      return;
    }
    timer?.cancel();
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
      steal = false;
      seconds = 60;
      clockFinished = false;
      award = null;
      used.add(q.id);
    });
    _startTimer(60);
    SharedPreferences.getInstance().then((prefs) => prefs.setStringList('huroof_used_questions_v1', used.toList()));
  }

  @override Widget build(BuildContext context) {
    final q = current;
    return Directionality(
      textDirection: widget.ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(title: Text(widget.ar ? 'تحدي الحروف' : 'Letter Challenge'), actions: [IconButton(tooltip: widget.ar ? 'تعديل أسماء الفرق' : 'Edit team names', onPressed: _editTeams, icon: const Icon(Icons.edit_outlined))]),
        body: SafeArea(child: loading ? const Center(child: CircularProgressIndicator()) : q == null
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(widget.ar ? 'انتهت أسئلة هذا المستوى' : 'No questions remaining at this level'),
              const SizedBox(height: 16),
              OutlinedButton(onPressed: () async {
                final confirmed = await showDialog<bool>(context: context, builder: (dialogContext) => AlertDialog(
                  title: Text(widget.ar ? 'إعادة الأسئلة؟' : 'Reset questions?'),
                  content: Text(widget.ar ? 'ستظهر أسئلة سبق لعبها. هل تريد المتابعة؟' : 'Previously played questions may appear again. Continue?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(widget.ar ? 'إلغاء' : 'Cancel')),
                    FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(widget.ar ? 'تأكيد' : 'Confirm')),
                  ],
                ));
                if (confirmed == true && mounted) await _resetProgress();
              }, child: Text(widget.ar ? 'إعادة جميع الأسئلة' : 'Reset questions')),
              const SizedBox(height: 12),
              _difficultyPicker(),
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
                  const SizedBox(height: 12),
                  _difficultyPicker(),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: _scoreTile(teamA, scoreA, 0)),
                    const SizedBox(width: 8),
                    Expanded(child: _scoreTile(teamB, scoreB, 1)),
                  ]),
                  const SizedBox(height: 10),
                  Center(child: Text(
                    widget.ar
                      ? (steal ? 'وقت السرقة: ${startingTeam == 0 ? teamB : teamA}' : 'دور: ${startingTeam == 0 ? teamA : teamB}')
                      : (steal ? 'Steal turn' : 'Answer turn'),
                    style: const TextStyle(color: gold, fontWeight: FontWeight.bold),
                  )),
                  Center(child: Text('$seconds', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: seconds <= 10 ? Colors.redAccent : Colors.white))),
                  if (clockFinished && !revealed) Center(child: Text(widget.ar ? 'انتهى وقت الفريقين' : 'Both turns ended', style: const TextStyle(color: Colors.orangeAccent))),
                  if (!steal && !revealed) ...[
                    const SizedBox(height: 6),
                    Center(child: OutlinedButton(
                      onPressed: _beginSteal,
                      child: Text(widget.ar ? 'انتقال الدور للفريق الثاني (15 ثانية)' : 'Pass to other team (15 seconds)'),
                    )),
                  ],
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
                  if (!revealed) FilledButton(
                    onPressed: _reveal,
                    child: Padding(padding: const EdgeInsets.all(10), child: Text(widget.ar ? 'إظهار الإجابة' : 'Reveal answer')),
                  ) else ...[
                    Text(widget.ar ? 'من يستحق النقاط؟' : 'Who gets the points?', textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
                      ChoiceChip(label: Text(teamA), selected: award == 0, onSelected: (_) => setState(() => award = 0)),
                      ChoiceChip(label: Text(teamB), selected: award == 1, onSelected: (_) => setState(() => award = 1)),
                      ChoiceChip(label: Text(widget.ar ? 'لا أحد' : 'Neither'), selected: award == -1, onSelected: (_) => setState(() => award = -1)),
                    ]),
                    const SizedBox(height: 10),
                    FilledButton(onPressed: award == null ? null : _confirmAward, child: Text(widget.ar ? 'تأكيد والانتقال للسؤال التالي' : 'Confirm & next question')),
                  ],
                ]),
              )),
            ))),
      ),
    );
  }
  Widget _difficultyPicker() => Wrap(
    alignment: WrapAlignment.center, spacing: 8, runSpacing: 6,
    children: QuestionDifficulty.values.map((difficulty) => ChoiceChip(
      label: Text('${difficulty.points}'),
      selected: selectedDifficulty == difficulty,
      onSelected: (_) {
        if (selectedDifficulty == difficulty) return;
        selectedDifficulty = difficulty;
        _next();
      },
    )).toList(),
  );

  Widget _scoreTile(String name, int score, int team) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: panel, borderRadius: BorderRadius.circular(12),
      border: Border.all(color: gold.withValues(alpha: .5)),
    ),
    child: Column(children: [
      Text(name, textAlign: TextAlign.center, style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
      Text('$score', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
    ]),
  );

}
