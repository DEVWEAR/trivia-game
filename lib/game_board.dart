import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'data/question_model.dart';
import 'data/questions/uae_general_final.dart';
import 'data/questions/uae_football_final.dart';

class BoardCategory {
  BoardCategory({required this.id, required this.ar, required this.en, required this.questions});
  final int id;
  final String ar, en;
  final List<TriviaQuestion> questions;
}

class BoardSlot {
  BoardSlot({required this.category, required this.points, required this.question});
  final BoardCategory category;
  final int points;
  final TriviaQuestion question;
  bool used = false;
}

List<BoardCategory> categoriesForIndexes(List<int> indexes) => indexes.map((i) {
  if (i == 0) return BoardCategory(id: 0, ar: 'الإمارات', en: 'UAE', questions: uaeGeneralFinalQuestions);
  return BoardCategory(id: 1, ar: 'كرة القدم الإماراتية', en: 'UAE Football', questions: uaeFootballFinalQuestions);
}).toList();

List<BoardSlot> makeSlots(BoardCategory c) {
  final out = <BoardSlot>[];
  for (final d in QuestionDifficulty.values) {
    final pool = c.questions.where((q) => q.difficulty == d).toList()..shuffle(Random.secure());
    for (final q in pool.take(2)) {
      out.add(BoardSlot(category: c, points: d.points, question: q));
    }
  }
  return out;
}

class TriviaBoardScreen extends StatefulWidget {
  const TriviaBoardScreen({super.key, required this.ar, required this.categoryIndexes, required this.teamA, required this.teamB});
  final bool ar;
  final List<int> categoryIndexes;
  final String teamA, teamB;
  @override State<TriviaBoardScreen> createState() => _TriviaBoardScreenState();
}

class _TriviaBoardScreenState extends State<TriviaBoardScreen> {
  late final List<BoardCategory> cats;
  late final Map<int, List<BoardSlot>> slots;
  int scoreA = 0, scoreB = 0, turn = 0;

  @override void initState() {
    super.initState();
    cats = categoriesForIndexes(widget.categoryIndexes);
    slots = {for (final c in cats) c.id: makeSlots(c)};
  }

  bool get finished => slots.values.expand((e) => e).every((s) => s.used);

  @override Widget build(BuildContext context) {
    final ar = widget.ar;
    return Directionality(textDirection: ar ? TextDirection.rtl : TextDirection.ltr, child: Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(ar ? 'لوحة المواجهة' : 'Showdown Board')),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
        Row(children: [Expanded(child: _score(widget.teamA, scoreA, turn == 0)), const SizedBox(width: 10), Expanded(child: _score(widget.teamB, scoreB, turn == 1))]),
        const SizedBox(height: 12),
        Text(ar ? 'الدور على ${turn == 0 ? widget.teamA : widget.teamB} • اختاروا الفئة والنقاط' : '${turn == 0 ? widget.teamA : widget.teamB} turn • choose category and points', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 18),
        for (final c in cats) _categoryCard(c),
      ])),
    ));
  }

  Widget _score(String name, int score, bool active) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: active ? const Color(0xFF6D52E8).withValues(alpha:.3) : Colors.white.withValues(alpha:.05), borderRadius: BorderRadius.circular(18), border: Border.all(color: active ? const Color(0xFF8E7AFF) : Colors.white10)), child: Column(children:[Text(name, maxLines:1, overflow:TextOverflow.ellipsis, style:const TextStyle(fontWeight:FontWeight.w800)), Text('$score', style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900))]));

  Widget _categoryCard(BoardCategory c) {
    final list = slots[c.id]!;
    return Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withValues(alpha:.05), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.ar ? c.ar : c.en, style: const TextStyle(fontSize:20,fontWeight:FontWeight.w900)), const SizedBox(height:12),
      GridView.builder(shrinkWrap:true, physics:const NeverScrollableScrollPhysics(), itemCount:list.length, gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:1.65, crossAxisSpacing:8, mainAxisSpacing:8), itemBuilder:(_,i){
        final s=list[i];
        return FilledButton.tonal(onPressed:s.used?null:()=>_open(s), style:FilledButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15))), child:s.used?const Icon(Icons.check_rounded):Text('${s.points}',style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900)));
      })
    ]));
  }

  Future<void> _open(BoardSlot slot) async {
    final awarded = await Navigator.push<int?>(context, MaterialPageRoute(builder: (_) => TimedQuestionScreen(ar: widget.ar, slot: slot, primaryTeam: turn, teamA: widget.teamA, teamB: widget.teamB)));
    if (!mounted || awarded == null) return;
    setState(() {
      slot.used = true;
      if (awarded == 0) scoreA += slot.points;
      if (awarded == 1) scoreB += slot.points;
      turn = 1 - turn;
    });
    if (finished && mounted) {
      await showDialog(context: context, barrierDismissible:false, builder:(ctx)=>AlertDialog(title:Text(widget.ar?'انتهت المواجهة 🏆':'Showdown complete 🏆'), content:Text('${widget.teamA}: $scoreA\n${widget.teamB}: $scoreB'), actions:[FilledButton(onPressed:()=>Navigator.pop(ctx), child:Text(widget.ar?'تمام':'Done'))]));
      if (mounted) Navigator.popUntil(context, (r)=>r.isFirst);
    }
  }
}

class TimedQuestionScreen extends StatefulWidget {
  const TimedQuestionScreen({super.key, required this.ar, required this.slot, required this.primaryTeam, required this.teamA, required this.teamB});
  final bool ar;
  final BoardSlot slot;
  final int primaryTeam;
  final String teamA, teamB;
  @override State<TimedQuestionScreen> createState()=>_TimedQuestionScreenState();
}

class _TimedQuestionScreenState extends State<TimedQuestionScreen> {
  Timer? timer;
  int seconds=60;
  bool steal=false, revealed=false;
  int? award;

  String teamName(int i)=>i==0?widget.teamA:widget.teamB;
  int get stealingTeam=>1-widget.primaryTeam;

  @override void initState(){super.initState();_start(60);}
  @override void dispose(){timer?.cancel();super.dispose();}

  void _start(int value){
    timer?.cancel(); seconds=value;
    timer=Timer.periodic(const Duration(seconds:1),(t){
      if(!mounted){t.cancel();return;}
      if(seconds<=1){t.cancel(); if(!steal){setState((){steal=true;seconds=15;});_start(15);}else{setState((){seconds=0;revealed=true;});}}else{setState(()=>seconds--);}
    });
  }

  void _showAnswer(){timer?.cancel();setState(()=>revealed=true);}

  @override Widget build(BuildContext context){
    final ar=widget.ar,q=widget.slot.question,p=widget.slot.points;
    final active=steal?stealingTeam:widget.primaryTeam;
    return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr, child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent,title:Text('${widget.ar?widget.slot.category.ar:widget.slot.category.en} • $p')), body:SafeArea(child:Padding(padding:const EdgeInsets.all(22),child:Column(children:[
      Container(width:110,height:110,alignment:Alignment.center,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:steal?Colors.orangeAccent:const Color(0xFF8FE8DF),width:5)),child:Text('$seconds',style:const TextStyle(fontSize:38,fontWeight:FontWeight.w900))),
      const SizedBox(height:12), Text(steal?(ar?'سرقة • ${teamName(active)}':'STEAL • ${teamName(active)}'):(ar?'وقت ${teamName(active)}':'${teamName(active)} time'),style:TextStyle(fontWeight:FontWeight.w900,color:steal?Colors.orangeAccent:const Color(0xFF8FE8DF))),
      const Spacer(), Text(ar?q.questionAr:q.questionEn,textAlign:TextAlign.center,style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900,height:1.4)), const SizedBox(height:24),
      if(revealed) Container(width:double.infinity,padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:const Color(0xFF6D52E8).withValues(alpha:.22),borderRadius:BorderRadius.circular(22)),child:Column(children:[Text(ar?'الإجابة':'Answer',style:const TextStyle(color:Colors.white60)),const SizedBox(height:6),Text(ar?q.answerAr:q.answerEn,textAlign:TextAlign.center,style:const TextStyle(fontSize:23,fontWeight:FontWeight.w900))])),
      const Spacer(),
      if(!revealed) SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:_showAnswer,child:Text(ar?'إظهار الإجابة':'Show answer'))),
      if(revealed)...[
        Text(ar?'من يستحق $p نقطة؟':'Who gets $p points?',style:const TextStyle(fontWeight:FontWeight.w800)),const SizedBox(height:10),
        Row(children:[Expanded(child:_awardButton(0,widget.teamA)),const SizedBox(width:8),Expanded(child:_awardButton(1,widget.teamB)),const SizedBox(width:8),Expanded(child:_awardButton(-1,ar?'لا أحد':'Nobody'))]),
        const SizedBox(height:12),SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:award==null?null:()=>Navigator.pop(context,award),child:Text(ar?'تأكيد':'Confirm')))
      ]
    ])))));
  }

  Widget _awardButton(int value,String label){final on=award==value;return OutlinedButton(onPressed:()=>setState(()=>award=value),style:OutlinedButton.styleFrom(backgroundColor:on?const Color(0xFF6D52E8).withValues(alpha:.35):null,padding:const EdgeInsets.symmetric(vertical:14)),child:Text(label,maxLines:1,overflow:TextOverflow.ellipsis));}
}
