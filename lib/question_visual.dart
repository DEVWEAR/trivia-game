import 'dart:math';
import 'package:flutter/material.dart';
import 'data/question_model.dart';
import 'data/playable_category_registry.dart';

/// Deterministic, locally-rendered visual artwork for EVERY question.
/// Each card derives its subject cues from its own question/answer, so visuals are
/// contextual rather than one repeated category image. No network dependency.
class QuestionVisual extends StatelessWidget {
  const QuestionVisual({super.key,required this.question,required this.ar});
  final TriviaQuestion question; final bool ar;

  String _categoryIcon() {
    // A question's category is authoritative. Never infer its icon from words
    // like "year" or "university" in the question text.
    if (question.categoryId.endsWith('_music')) return '🎶';
    for (final category in playableCategories) {
      if (category.categoryId == question.categoryId) return category.icon;
    }
    return '💡';
  }

  @override Widget build(BuildContext context){
    final symbol=_categoryIcon(); final seed=question.id.codeUnits.fold<int>(7,(a,b)=>a*31+b); final points=question.difficulty.points;
    return AspectRatio(aspectRatio:16/6.6,child:ClipRRect(borderRadius:BorderRadius.circular(24),child:Stack(fit:StackFit.expand,children:[
      CustomPaint(painter:_VisualPainter(seed:seed,category:question.categoryId,points:points)),
      Positioned.fill(child:DecoratedBox(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,Colors.black.withValues(alpha:.48)])))),
      Center(child:Transform.rotate(angle:(seed%9-4)*.008,child:Container(width:104,height:104,alignment:Alignment.center,decoration:BoxDecoration(borderRadius:BorderRadius.circular(30),color:Colors.black.withValues(alpha:.24),border:Border.all(color:Colors.white.withValues(alpha:.20),width:1.4),boxShadow:[BoxShadow(color:Colors.black.withValues(alpha:.22),blurRadius:25)]),child:Text(symbol,style:const TextStyle(fontSize:57))))),

    ])));
  }
}

class _VisualPainter extends CustomPainter{
 const _VisualPainter({required this.seed,required this.category,required this.points}); final int seed,points; final String category;
 @override void paint(Canvas canvas,Size size){final r=Random(seed);final palette=switch(category){'uae_general'=>[const Color(0xFF071F19),const Color(0xFF12634B),const Color(0xFF151515)],'uae_football'=>[const Color(0xFF052922),const Color(0xFF08745A),const Color(0xFF08151B)],'general_knowledge'=>[const Color(0xFF101D38),const Color(0xFF24577C),const Color(0xFF17132E)],'brain'=>[const Color(0xFF20103E),const Color(0xFF64328A),const Color(0xFF111827)],'gaming'=>[const Color(0xFF151039),const Color(0xFF5036BA),const Color(0xFF062236)],'no_words'=>[const Color(0xFF321126),const Color(0xFF8A2953),const Color(0xFF16101D)],_=>[const Color(0xFF102438),const Color(0xFF176B87),const Color(0xFF17133B)]};canvas.drawRect(Offset.zero&size,Paint()..shader=LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:palette).createShader(Offset.zero&size));
   final grid=Paint()..color=Colors.white.withValues(alpha:.045)..strokeWidth=.8;final gap=26.0;for(double x=(seed%20).toDouble();x<size.width;x+=gap)canvas.drawLine(Offset(x,0),Offset(x,size.height),grid);for(double y=(seed%15).toDouble();y<size.height;y+=gap)canvas.drawLine(Offset(0,y),Offset(size.width,y),grid);
   for(int i=0;i<8;i++){final p=Offset(r.nextDouble()*size.width,r.nextDouble()*size.height),rad=18+r.nextDouble()*72;canvas.drawCircle(p,rad,Paint()..style=PaintingStyle.stroke..strokeWidth=.8+r.nextDouble()*1.3..color=Colors.white.withValues(alpha:.025+r.nextDouble()*.055));}
   final path=Path();for(int i=0;i<8;i++){final x=size.width*i/7,y=size.height*(.28+r.nextDouble()*.44);i==0?path.moveTo(x,y):path.lineTo(x,y);}canvas.drawPath(path,Paint()..style=PaintingStyle.stroke..strokeWidth=1.5..color=Colors.white.withValues(alpha:.10));

 }
 @override bool shouldRepaint(covariant _VisualPainter old)=>old.seed!=seed||old.category!=category||old.points!=points;
}
