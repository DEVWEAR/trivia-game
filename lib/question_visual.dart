import 'dart:math';
import 'package:flutter/material.dart';
import 'data/question_model.dart';

/// Lightweight, original visual system for every trivia card.
/// It is rendered locally (no slow/unsafe third-party image hotlinks), stays crisp
/// at any resolution, and uses each question id/category/difficulty as its seed.
class QuestionVisual extends StatelessWidget {
  const QuestionVisual({super.key, required this.question, required this.ar});
  final TriviaQuestion question;
  final bool ar;

  static const _meta = <String, (String,String,String)> {
    'uae_general': ('🇦🇪','الإمارات','UAE'),
    'uae_football': ('⚽','كرة القدم الإماراتية','UAE Football'),
    'general_knowledge': ('🌐','معلومات عامة','General Knowledge'),
    'brain': ('🧠','ألغاز وذكاء','Brain & Riddles'),
    'gaming': ('🎮','ألعاب الفيديو','Gaming'),
    'no_words': ('🎯','ولا كلمة','No Words'),
    'two_pics': ('🖼️','صورتين كلمة واحدة','Two Pics One Word'),
  };

  @override
  Widget build(BuildContext context) {
    final m = _meta[question.categoryId] ?? ('✦','تحدي','Challenge');
    final seed = question.id.codeUnits.fold<int>(0,(a,b)=>a+b*31);
    final points = question.difficulty.points;
    return AspectRatio(
      aspectRatio: 16/7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(fit: StackFit.expand, children:[
          CustomPaint(painter:_FutureVisualPainter(seed:seed,category:question.categoryId,points:points)),
          Positioned.fill(child:DecoratedBox(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,Colors.black.withValues(alpha:.38)])))),
          Center(child:Container(width:86,height:86,alignment:Alignment.center,decoration:BoxDecoration(shape:BoxShape.circle,color:Colors.black.withValues(alpha:.25),border:Border.all(color:Colors.white.withValues(alpha:.22))),child:Text(m.$1,style:const TextStyle(fontSize:46)))),
          PositionedDirectional(start:14,bottom:12,child:Container(padding:const EdgeInsets.symmetric(horizontal:11,vertical:6),decoration:BoxDecoration(color:Colors.black.withValues(alpha:.35),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white12)),child:Text(ar?m.$2:m.$3,style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:Colors.white)))),
          PositionedDirectional(end:14,top:12,child:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:5),decoration:BoxDecoration(color:Colors.black.withValues(alpha:.28),borderRadius:BorderRadius.circular(20)),child:Text('$points',style:const TextStyle(fontSize:12,fontWeight:FontWeight.w900,color:Colors.white)))),
        ]),
      ),
    );
  }
}

class _FutureVisualPainter extends CustomPainter {
  const _FutureVisualPainter({required this.seed,required this.category,required this.points});
  final int seed; final String category; final int points;
  @override void paint(Canvas canvas, Size size) {
    final r=Random(seed);
    final palette=switch(category){
      'uae_general'=>[const Color(0xFF082A22),const Color(0xFF0B5B47),const Color(0xFF111827)],
      'uae_football'=>[const Color(0xFF062C28),const Color(0xFF0E6655),const Color(0xFF07151D)],
      'general_knowledge'=>[const Color(0xFF13203A),const Color(0xFF244B78),const Color(0xFF15122D)],
      'brain'=>[const Color(0xFF251446),const Color(0xFF5B2B82),const Color(0xFF101525)],
      'gaming'=>[const Color(0xFF17113A),const Color(0xFF4931A8),const Color(0xFF071C2D)],
      'no_words'=>[const Color(0xFF301228),const Color(0xFF7B244B),const Color(0xFF18101F)],
      'two_pics'=>[const Color(0xFF10273A),const Color(0xFF176B87),const Color(0xFF17133B)],
      _=>[const Color(0xFF141B2D),const Color(0xFF394867),const Color(0xFF11131C)]};
    final bg=Paint()..shader=LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:palette).createShader(Offset.zero&size);
    canvas.drawRect(Offset.zero&size,bg);
    final glow=Paint()..style=PaintingStyle.stroke..strokeWidth=1.2;
    for(int i=0;i<10;i++){
      final x=r.nextDouble()*size.width,y=r.nextDouble()*size.height,rad=12+r.nextDouble()*70;
      glow.color=Colors.white.withValues(alpha:.035+r.nextDouble()*.06);
      canvas.drawCircle(Offset(x,y),rad,glow);
    }
    final line=Paint()..color=Colors.white.withValues(alpha:.07)..strokeWidth=1;
    for(int i=0;i<7;i++){
      final y=size.height*(i+1)/8;
      canvas.drawLine(Offset(0,y),Offset(size.width,y+(r.nextDouble()-.5)*18),line);
    }
    final accent=Paint()..color=Colors.white.withValues(alpha:.13)..strokeWidth=2..style=PaintingStyle.stroke;
    final path=Path();
    for(int i=0;i<6;i++){
      final x=size.width*i/5,y=size.height*(.25+r.nextDouble()*.5);
      if(i==0)path.moveTo(x,y);else path.lineTo(x,y);
    }
    canvas.drawPath(path,accent);
    final dot=Paint()..color=Colors.white.withValues(alpha:.28);
    for(int i=0;i<points~/100;i++) canvas.drawCircle(Offset(size.width-18-i*9,18),2.2,dot);
  }
  @override bool shouldRepaint(covariant _FutureVisualPainter old)=>old.seed!=seed||old.category!=category||old.points!=points;
}
