import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/question_model.dart';
import 'data/questions/uae_general_final.dart';
import 'data/questions/uae_football_final.dart';

class BoardCategory {
  BoardCategory({required this.id, required this.ar, required this.en, required this.questions});
  final int id; final String ar, en; final List<TriviaQuestion> questions;
}
class BoardSlot {
  BoardSlot({required this.category, required this.points, required this.question});
  final BoardCategory category; final int points; final TriviaQuestion question; bool used=false;
}
List<BoardCategory> categoriesForIndexes(List<int> indexes)=>indexes.map((i)=>i==0?BoardCategory(id:0,ar:'الإمارات',en:'UAE',questions:uaeGeneralFinalQuestions):BoardCategory(id:1,ar:'كرة القدم الإماراتية',en:'UAE Football',questions:uaeFootballFinalQuestions)).toList();
List<BoardSlot> makeSlots(BoardCategory c){final out=<BoardSlot>[];for(final d in QuestionDifficulty.values){final pool=c.questions.where((q)=>q.difficulty==d).toList()..shuffle(Random.secure());for(final q in pool.take(2)){out.add(BoardSlot(category:c,points:d.points,question:q));}}return out;}

class TriviaBoardScreen extends StatefulWidget {
  const TriviaBoardScreen({super.key,required this.ar,required this.categoryIndexes,required this.teamA,required this.teamB});
  final bool ar; final List<int> categoryIndexes; final String teamA,teamB;
  @override State<TriviaBoardScreen> createState()=>_TriviaBoardScreenState();
}
class _TriviaBoardScreenState extends State<TriviaBoardScreen>{
  late final List<BoardCategory> cats; late final Map<int,List<BoardSlot>> slots; int scoreA=0,scoreB=0,turn=0;
  @override void initState(){super.initState();cats=categoriesForIndexes(widget.categoryIndexes);slots={for(final c in cats)c.id:makeSlots(c)};SystemChrome.setPreferredOrientations(const[DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);}
  @override void dispose(){SystemChrome.setPreferredOrientations(const[DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);super.dispose();}
  bool get finished=>slots.values.expand((e)=>e).every((s)=>s.used);
  @override Widget build(BuildContext context){final ar=widget.ar;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(toolbarHeight:44,backgroundColor:Colors.transparent,title:Text(ar?'لوحة المواجهة':'Showdown Board',style:const TextStyle(fontWeight:FontWeight.w900))),body:SafeArea(child:LayoutBuilder(builder:(context,box){final wide=box.maxWidth>box.maxHeight;return Padding(padding:const EdgeInsets.fromLTRB(14,2,14,12),child:Column(children:[Row(children:[Expanded(child:_score(widget.teamA,scoreA,turn==0)),const SizedBox(width:8),Expanded(flex:2,child:Text(ar?'الدور على ${turn==0?widget.teamA:widget.teamB} • اختاروا الفئة والنقاط':'${turn==0?widget.teamA:widget.teamB} turn • choose category and points',textAlign:TextAlign.center,maxLines:2,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w800))),const SizedBox(width:8),Expanded(child:_score(widget.teamB,scoreB,turn==1))]),const SizedBox(height:10),Expanded(child:wide?_wideBoard():_portraitBoard())]));}))));}
  Widget _wideBoard()=>Row(crossAxisAlignment:CrossAxisAlignment.stretch,children:[for(int i=0;i<cats.length;i++)...[if(i>0)const SizedBox(width:12),Expanded(child:_categoryCard(cats[i],compact:false))]]);
  Widget _portraitBoard()=>ListView.separated(itemCount:cats.length,separatorBuilder:(_,__)=>const SizedBox(height:10),itemBuilder:(_,i)=>SizedBox(height:210,child:_categoryCard(cats[i],compact:true)));
  Widget _score(String name,int score,bool active)=>AnimatedContainer(duration:const Duration(milliseconds:180),padding:const EdgeInsets.symmetric(horizontal:10,vertical:7),decoration:BoxDecoration(gradient:active?const LinearGradient(colors:[Color(0xFF6D52E8),Color(0xFF4330A7)]):null,color:active?null:const Color(0xFF171923),borderRadius:BorderRadius.circular(14),border:Border.all(color:active?const Color(0xFF9C8CFF):Colors.white12)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Flexible(child:Text(name,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:13,fontWeight:FontWeight.w800))),const SizedBox(width:7),Text('$score',style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900))]));
  Color _pointColor(int p)=>p==200?const Color(0xFF159C93):p==400?const Color(0xFF5C4ED8):const Color(0xFFB86B24);
  Widget _categoryCard(BoardCategory c,{required bool compact}){
    final list=slots[c.id]!;
    return Container(
      padding:const EdgeInsets.all(13),
      decoration:BoxDecoration(
        gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF171925),Color(0xFF10121B)]),
        borderRadius:BorderRadius.circular(20),
        border:Border.all(color:Colors.white12),
      ),
      child:Column(children:[
        Text(widget.ar?c.ar:c.en,textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis,style:TextStyle(fontSize:compact?18:20,fontWeight:FontWeight.w900)),
        const SizedBox(height:10),
        Expanded(
          child:GridView.builder(
            physics:const NeverScrollableScrollPhysics(),
            itemCount:list.length,
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:compact?2.15:2.3,crossAxisSpacing:8,mainAxisSpacing:8),
            itemBuilder:(_,i){
              final s=list[i];
              return Material(
                color:Colors.transparent,
                child:InkWell(
                  onTap:s.used?null:()=>_open(s),
                  borderRadius:BorderRadius.circular(13),
                  child:Ink(
                    decoration:BoxDecoration(
                      color:s.used?const Color(0xFF252733):_pointColor(s.points),
                      borderRadius:BorderRadius.circular(13),
                      boxShadow:s.used?null:[BoxShadow(color:_pointColor(s.points).withValues(alpha:.20),blurRadius:10,offset:const Offset(0,4))],
                    ),
                    child:Center(
                      child:s.used
                        ?const Icon(Icons.check_rounded,size:22,color:Colors.white38)
                        :FittedBox(fit:BoxFit.scaleDown,child:Padding(padding:const EdgeInsets.symmetric(horizontal:6),child:Text('${s.points}',maxLines:1,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900,color:Colors.white)))),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
  Future<void> _open(BoardSlot slot)async{final awarded=await Navigator.push<int?>(context,MaterialPageRoute(builder:(_)=>TimedQuestionScreen(ar:widget.ar,slot:slot,primaryTeam:turn,teamA:widget.teamA,teamB:widget.teamB)));if(!mounted||awarded==null)return;setState((){slot.used=true;if(awarded==0)scoreA+=slot.points;if(awarded==1)scoreB+=slot.points;turn=1-turn;});if(finished&&mounted){await showDialog(context:context,barrierDismissible:false,builder:(ctx)=>AlertDialog(title:Text(widget.ar?'انتهت المواجهة 🏆':'Showdown complete 🏆'),content:Text('${widget.teamA}: $scoreA\n${widget.teamB}: $scoreB'),actions:[FilledButton(onPressed:()=>Navigator.pop(ctx),child:Text(widget.ar?'تمام':'Done'))]));if(mounted){await SystemChrome.setPreferredOrientations(const[DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);if(mounted)Navigator.popUntil(context,(r)=>r.isFirst);}}}
}

class TimedQuestionScreen extends StatefulWidget{
  const TimedQuestionScreen({super.key,required this.ar,required this.slot,required this.primaryTeam,required this.teamA,required this.teamB});final bool ar;final BoardSlot slot;final int primaryTeam;final String teamA,teamB;@override State<TimedQuestionScreen> createState()=>_TimedQuestionScreenState();}
class _TimedQuestionScreenState extends State<TimedQuestionScreen>{
  Timer? timer;int seconds=60;bool steal=false,revealed=false;int? award;String teamName(int i)=>i==0?widget.teamA:widget.teamB;int get stealingTeam=>1-widget.primaryTeam;
  @override void initState(){super.initState();_start(60);}@override void dispose(){timer?.cancel();super.dispose();}
  void _start(int value){timer?.cancel();seconds=value;timer=Timer.periodic(const Duration(seconds:1),(t){if(!mounted){t.cancel();return;}if(seconds<=1){t.cancel();if(!steal){setState((){steal=true;seconds=15;});_start(15);}else{setState((){seconds=0;revealed=true;});}}else{setState(()=>seconds--);}});}
  void _showAnswer(){timer?.cancel();setState(()=>revealed=true);}
  @override Widget build(BuildContext context){final ar=widget.ar,q=widget.slot.question,p=widget.slot.points,active=steal?stealingTeam:widget.primaryTeam;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(toolbarHeight:44,backgroundColor:Colors.transparent,title:Text('${ar?widget.slot.category.ar:widget.slot.category.en} • $p')),body:SafeArea(child:LayoutBuilder(builder:(context,box){final wide=box.maxWidth>box.maxHeight;final timerBox=_timer(active);final content=_questionContent(ar,q,p);return Padding(padding:const EdgeInsets.fromLTRB(16,2,16,12),child:wide?Row(children:[SizedBox(width:145,child:timerBox),const SizedBox(width:14),Expanded(child:content)]):Column(children:[SizedBox(height:115,child:timerBox),const SizedBox(height:8),Expanded(child:SingleChildScrollView(child:content))]));}))));}
  Widget _timer(int active)=>Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(width:88,height:88,alignment:Alignment.center,decoration:BoxDecoration(shape:BoxShape.circle,color:const Color(0xFF151721),border:Border.all(color:steal?const Color(0xFFFFA34D):const Color(0xFF43D5C7),width:4)),child:Text('$seconds',style:const TextStyle(fontSize:31,fontWeight:FontWeight.w900))),const SizedBox(height:7),Text(steal?(widget.ar?'سرقة • ${teamName(active)}':'STEAL • ${teamName(active)}'):(widget.ar?'وقت ${teamName(active)}':'${teamName(active)} time'),textAlign:TextAlign.center,maxLines:2,style:TextStyle(fontSize:12,fontWeight:FontWeight.w900,color:steal?const Color(0xFFFFA34D):const Color(0xFF43D5C7)))]);
  Widget _questionContent(bool ar,TriviaQuestion q,int p)=>Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(ar?q.questionAr:q.questionEn,textAlign:TextAlign.center,style:const TextStyle(fontSize:23,fontWeight:FontWeight.w900,height:1.3)),const SizedBox(height:14),if(revealed)Container(width:double.infinity,padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:const Color(0xFF211C48),borderRadius:BorderRadius.circular(16),border:Border.all(color:const Color(0xFF6D5CE7))),child:Column(children:[Text(ar?'الإجابة':'Answer',style:const TextStyle(fontSize:12,color:Colors.white60)),const SizedBox(height:4),Text(ar?q.answerAr:q.answerEn,textAlign:TextAlign.center,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900))])),const SizedBox(height:13),if(!revealed)SizedBox(width:220,height:46,child:FilledButton(onPressed:_showAnswer,child:Text(ar?'إظهار الإجابة':'Show answer'))),if(revealed)...[Text(ar?'من يستحق $p نقطة؟':'Who gets $p points?',style:const TextStyle(fontWeight:FontWeight.w800)),const SizedBox(height:7),Row(children:[Expanded(child:_awardButton(0,widget.teamA)),const SizedBox(width:7),Expanded(child:_awardButton(1,widget.teamB)),const SizedBox(width:7),Expanded(child:_awardButton(-1,ar?'لا أحد':'Nobody'))]),const SizedBox(height:8),SizedBox(width:220,height:45,child:FilledButton(onPressed:award==null?null:()=>Navigator.pop(context,award),child:Text(ar?'تأكيد':'Confirm')))] ]);
  Widget _awardButton(int value,String label){final on=award==value;return OutlinedButton(onPressed:()=>setState(()=>award=value),style:OutlinedButton.styleFrom(backgroundColor:on?const Color(0xFF5C4ED8):const Color(0xFF171923),padding:const EdgeInsets.symmetric(vertical:11)),child:Text(label,maxLines:1,overflow:TextOverflow.ellipsis));}
}
