import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'game_board.dart';
import 'data/playable_category_registry.dart';

void main() => runApp(const TriviaGameApp());

class TriviaGameApp extends StatefulWidget {const TriviaGameApp({super.key});@override State<TriviaGameApp> createState()=>_TriviaGameAppState();}
class _TriviaGameAppState extends State<TriviaGameApp>{Locale locale=const Locale('ar');@override Widget build(BuildContext context)=>MaterialApp(debugShowCheckedModeBanner:false,theme:ThemeData(useMaterial3:true,brightness:Brightness.dark,scaffoldBackgroundColor:const Color(0xFF211A20),colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFFC99A58),brightness:Brightness.dark),appBarTheme:const AppBarTheme(backgroundColor:Color(0xFF211A20),foregroundColor:Colors.white),cardTheme:CardThemeData(color:const Color(0xFF302327)),filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(backgroundColor:const Color(0xFFC99A58),foregroundColor:const Color(0xFF211A20))),outlinedButtonTheme:OutlinedButtonThemeData(style:OutlinedButton.styleFrom(foregroundColor:const Color(0xFFC99A58),side:const BorderSide(color:Color(0xFFC99A58))))),home:HomeScreen(locale:locale,changeLanguage:()=>setState(()=>locale=locale.languageCode=='ar'?const Locale('en'):const Locale('ar'))));}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,required this.locale,required this.changeLanguage});
  final Locale locale;
  final VoidCallback changeLanguage;
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController slideController=AnimationController(vsync:this,duration:const Duration(milliseconds:320));
  bool sliding=false;
  void advanceBackground(){
    if(!mounted||sliding||!firstFrameReady)return;
    setState(()=>sliding=true);
    slideController.forward(from:0).then((_){
      if(!mounted)return;
      setState((){imageIndex=(imageIndex+1)%backgrounds.length;sliding=false;});
      slideController.reset();
    });
  }
  int imageIndex=0;
  Timer? imageTimer;
  bool backgroundsReady=false;
  bool firstFrameReady=false;
  static const backgrounds=[
    '83A426BC-6461-4BD6-BB12-7877AED62765.png',
    '7E6D631D-725E-465C-86D6-3C6F57959964.png',
    '09F41FAC-F8B2-49DB-A6B4-08D1ACE61399.png',
  ];
  @override void initState(){
    super.initState();
  }
  @override void didChangeDependencies(){
    super.didChangeDependencies();
    if(backgroundsReady)return;
    backgroundsReady=true;
    // Show the first portrait as soon as it is decoded; warm up the next
    // images in the background without delaying the initial screen.
    precacheImage(AssetImage(backgrounds[0]),context).then((_){
      if(!mounted)return;
      setState(()=>firstFrameReady=true);
      Future.wait(backgrounds.skip(1).map((path)=>precacheImage(AssetImage(path),context)))
        .then((_){
          if(!mounted)return;
          imageTimer=Timer.periodic(const Duration(seconds:5),(_){
            advanceBackground();
          });
        }).catchError((_){
          // Keep the first image if a later image cannot be decoded.
        });
    }).catchError((_){
      // The browser first-paint background stays visible while loading.
    });
  }
  @override void dispose(){imageTimer?.cancel();slideController.dispose();super.dispose();}
  @override Widget build(BuildContext context){
    final ar=widget.locale.languageCode=='ar';
    return Directionality(
      textDirection:ar?TextDirection.rtl:TextDirection.ltr,
      child:Scaffold(
        extendBodyBehindAppBar:true,
        appBar:AppBar(
          backgroundColor:Colors.transparent,
          title:Text(ar?'جاهز للتحدي؟':'Ready to challenge?'),
          actions:[TextButton(
            onPressed:widget.changeLanguage,
            child:Text(ar?'English':'العربية',
              style:const TextStyle(fontWeight:FontWeight.w800,color:Color(0xFFC99A58))),
          )],
        ),
        body:Stack(fit:StackFit.expand,children:[
          const ColoredBox(color:Color(0xFF211A20)),
          if(firstFrameReady) Positioned.fill(
            child:ClipRect(
              child:LayoutBuilder(builder:(context,constraints){
                final width=constraints.maxWidth;
                Widget frame(int index)=>SizedBox(
                  width:width+3,
                  height:constraints.maxHeight,
                  child:Image.asset(
                    backgrounds[index],
                    fit:BoxFit.cover,
                    alignment:const Alignment(0.75,0),
                    gaplessPlayback:true,
                    filterQuality:FilterQuality.low,
                  ),
                );
                return AnimatedBuilder(
                  animation:slideController,
                  builder:(context,_){
                    final progress=Curves.easeInOutCubic.transform(slideController.value);
                    return Stack(clipBehavior:Clip.hardEdge,children:[
                      Positioned(left:-width*progress,top:0,bottom:0,child:frame(imageIndex)),
                      if(sliding) Positioned(
                        left:width*(1-progress)-3,top:0,bottom:0,
                        child:frame((imageIndex+1)%backgrounds.length),
                      ),
                    ]);
                  },
                );
              }),
            ),
          ),
          const ColoredBox(color:Color(0x8A1B1210)),
          SafeArea(
            child:ListView(padding:const EdgeInsets.all(20),children:[
              Container(
                padding:const EdgeInsets.all(22),
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(28),
                  gradient:const LinearGradient(colors:[Color(0xE8211A20),Color(0xDB2B1C16)]),
                ),
                child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Text(ar?'أول لعبة علينا 🎁':'Your first game is on us 🎁',
                    style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900,color:Color(0xFFF5E8D6))),
                  const SizedBox(height:20),
                  FilledButton.icon(
                    onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>CategoryScreen(ar:ar))),
                    icon:const Icon(Icons.play_arrow_rounded),
                    label:Text(ar?'ابدأ التحدي':'Start the challenge'),
                  ),
                ]),
              ),
              const SizedBox(height:28),
              Text(ar?'شرح اللعبة:':'How to play:',
                style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900,color:Color(0xFFF5E8D6))),
              const SizedBox(height:10),
              Text(
                ar?'اختاروا فئاتكم، وتنافسوا بين فريقين على أسئلة بقيمة 200 و400 و600 نقطة. عندكم 60 ثانية للإجابة، و15 ثانية لسرقة السؤال. الفريق الأعلى نقاط يفوز! 🏆'
                  :'Choose your categories and compete in two teams for 200, 400, or 600 points. You have 60 seconds to answer, plus 15 seconds to steal. The team with the most points wins! 🏆',
                style:const TextStyle(fontSize:15,height:1.7,color:Color(0xFFF5E8D6)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
class CategoryScreen extends StatefulWidget{const CategoryScreen({super.key,required this.ar});final bool ar;@override State<CategoryScreen> createState()=>_CategoryScreenState();}
class _CategoryScreenState extends State<CategoryScreen>{final selected=<int>{};final search=TextEditingController();String query='';final cats=playableCategories.map((c)=><String>[c.icon,c.ar,c.en]).toList();@override void dispose(){search.dispose();super.dispose();}List<int> get filteredIndexes{final q=query.trim().toLowerCase();if(q.isEmpty)return List.generate(cats.length,(i)=>i);return List.generate(cats.length,(i)=>i).where((i)=>cats[i][1].toLowerCase().contains(q)||cats[i][2].toLowerCase().contains(q)).toList();}@override Widget build(BuildContext context){final ar=widget.ar;final visible=filteredIndexes;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'اصنع المواجهة':'Build the showdown')),body:Column(children:[Expanded(child:ListView(children:[Padding(padding:const EdgeInsets.fromLTRB(20,4,20,10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'اختر من فئة إلى 6 فئات':'Choose 1 to 6 categories',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(ar?'${selected.length}/6 مختارة':'${selected.length}/6 selected',style:const TextStyle(color:Colors.white60)),const SizedBox(height:14),TextField(controller:search,onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(hintText:ar?'ابحث عن فئة...':'Search categories...',prefixIcon:const Icon(Icons.search_rounded),filled:true,fillColor:Colors.white.withValues(alpha:.06),border:OutlineInputBorder(borderRadius:BorderRadius.circular(18))))])),GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),padding:const EdgeInsets.symmetric(horizontal:20),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.05,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:visible.length,itemBuilder:(_,p){final i=visible[p],c=cats[i];final on=selected.contains(i);return InkWell(onTap:()=>setState((){if(on){selected.remove(i);}else if(selected.length<6){selected.add(i);}}),borderRadius:BorderRadius.circular(24),child:Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(24),border:Border.all(color:on?const Color(0xFFC99A58):Colors.white24,width:on?2:1)),child:ClipRRect(borderRadius:BorderRadius.circular(23),child:Stack(fit:StackFit.expand,children:[CustomPaint(painter:CategoryArtworkPainter(categoryId:playableCategories[i].categoryId)),DecoratedBox(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,const Color(0x440F0D17),const Color(0xF20E0D15)],stops:const [0.36,0.65,1]))),Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Spacer(),Text(ar?c[1]:c[2],maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900,color:Colors.white,shadows:[Shadow(color:Colors.black,blurRadius:8)])),const SizedBox(height:5),Text(ar?'${playableCategories[i].questions.length} بطاقة':'${playableCategories[i].questions.length} cards',style:const TextStyle(color:Color(0xFFFFC978),fontWeight:FontWeight.w700)),])),if(on)const Positioned(top:10,right:10,child:Icon(Icons.check_circle,color:Color(0xFFFFC978),size:28))]))));})])),SafeArea(top:false,child:Padding(padding:const EdgeInsets.all(20),child:SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:selected.isEmpty?null:(){final fresh=selected.toList()..shuffle(Random(DateTime.now().microsecondsSinceEpoch));Navigator.push(context,MaterialPageRoute(builder:(_)=>TeamSetup(ar:ar,selectedCategoryIndexes:fresh)));},child:Text(ar?'التالي • جهّز الفريقين':'Next • Set up teams'))))) ])));}}
class TeamSetup extends StatefulWidget{const TeamSetup({super.key,required this.ar,required this.selectedCategoryIndexes});final bool ar;final List<int> selectedCategoryIndexes;@override State<TeamSetup> createState()=>_TeamSetupState();}
class _TeamSetupState extends State<TeamSetup>{final a=TextEditingController(),b=TextEditingController();@override void dispose(){a.dispose();b.dispose();super.dispose();}@override Widget build(BuildContext context){final ar=widget.ar;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent),body:Padding(padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'سمّوا الفريقين':'Name your teams',style:const TextStyle(fontSize:29,fontWeight:FontWeight.w900)),const SizedBox(height:30),TeamField(controller:a,label:ar?'اسم الفريق الأول':'First team name'),const SizedBox(height:14),TeamField(controller:b,label:ar?'اسم الفريق الثاني':'Second team name'),const Spacer(),SizedBox(width:double.infinity,height:58,child:FilledButton(onPressed:(){final aa=a.text.trim().isEmpty?(ar?'الفريق الأول':'Team One'):a.text.trim(),bb=b.text.trim().isEmpty?(ar?'الفريق الثاني':'Team Two'):b.text.trim();final seed=DateTime.now().microsecondsSinceEpoch;for(final i in widget.selectedCategoryIndexes){categoryForIndex(i).questions.shuffle(Random(seed^(i+1)*7919));}final freshIndexes=List<int>.of(widget.selectedCategoryIndexes)..shuffle(Random(seed));Navigator.push(context,MaterialPageRoute(builder:(_)=>TriviaBoardScreen(key:ValueKey(seed),ar:ar,categoryIndexes:freshIndexes,teamA:aa,teamB:bb)));},child:Text(ar?'ابدأ المواجهة':'Start the showdown',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900))))]))));}}
class TeamField extends StatelessWidget{const TeamField({super.key,required this.controller,required this.label});final TextEditingController controller;final String label;@override Widget build(BuildContext context)=>TextField(controller:controller,decoration:InputDecoration(hintText:label,filled:true,fillColor:Colors.white.withValues(alpha:.05),contentPadding:const EdgeInsets.symmetric(horizontal:22,vertical:22),border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none)));}
BoxDecoration card()=>BoxDecoration(color:Colors.white.withValues(alpha:.055),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.09)));


class CategoryArtworkPainter extends CustomPainter {
  const CategoryArtworkPainter({required this.categoryId});
  final String categoryId;
  @override void paint(Canvas canvas, Size size) {
    final w=size.width,h=size.height,world=categoryId=='world_cup';
    final base=Paint()..shader=LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:world?const [Color(0xFF07162A),Color(0xFF132F46),Color(0xFF5C351C)]:const [Color(0xFF700C1D),Color(0xFF20253D),Color(0xFF0B152A)]).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size,base);
    final glow=Paint()..shader=RadialGradient(colors:[world?const Color(0xB5FFC66B):const Color(0x9BE5E5FF),Colors.transparent]).createShader(Rect.fromCircle(center:Offset(w*.5,h*.43),radius:w*.64));
    canvas.drawCircle(Offset(w*.5,h*.43),w*.64,glow);
    final stroke=Paint()..style=PaintingStyle.stroke..strokeWidth=1.2..color=const Color(0x65E5B975);
    for(var j=0;j<5;j++){canvas.drawOval(Rect.fromCenter(center:Offset(w*.5,h*.46),width:w*(.42+j*.16),height:h*(.17+j*.055)),stroke);}
    final stands=Paint()..color=const Color(0x99080A17);
    final stadium=Path()..moveTo(0,h*.55)..quadraticBezierTo(w*.5,h*.78,w,h*.55)..lineTo(w,h)..lineTo(0,h)..close();
    canvas.drawPath(stadium,stands);
    final crowd=Paint()..color=const Color(0x80E6B76C);
    for(var row=0;row<7;row++){for(var col=0;col<30;col++){final x=(col+.5)*w/30,y=h*(.62+row*.033)+12*math.sin(x/w*math.pi);canvas.drawCircle(Offset(x,y),.5+(col%3)*.22,crowd);}}
    if(world){
      final trophy=Paint()..color=const Color(0xFFFFD27A);
      final shadow=Paint()..color=const Color(0xFFAF7330);
      canvas.drawOval(Rect.fromCenter(center:Offset(w*.5,h*.24),width:w*.25,height:h*.19),trophy);
      canvas.drawArc(Rect.fromCenter(center:Offset(w*.5,h*.25),width:w*.40,height:h*.19),0.15,math.pi*.85,false,Paint()..color=const Color(0xFFFFD27A)..style=PaintingStyle.stroke..strokeWidth=w*.028);
      canvas.drawArc(Rect.fromCenter(center:Offset(w*.5,h*.25),width:w*.40,height:h*.19),math.pi,math.pi*.85,false,Paint()..color=const Color(0xFFFFD27A)..style=PaintingStyle.stroke..strokeWidth=w*.028);
      final stem=Path()..moveTo(w*.43,h*.32)..quadraticBezierTo(w*.51,h*.40,w*.44,h*.53)..lineTo(w*.56,h*.53)..quadraticBezierTo(w*.49,h*.40,w*.57,h*.32)..close();
      canvas.drawPath(stem,trophy);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.36,h*.52,w*.28,h*.045),Radius.circular(w*.01)),shadow);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*.32,h*.56,w*.36,h*.038),Radius.circular(w*.01)),trophy);
      for(var k=0;k<10;k++){final a=k*math.pi/5;canvas.drawCircle(Offset(w*.5+math.cos(a)*w*.37,h*.31+math.sin(a)*h*.12),1.4,Paint()..color=const Color(0xFFFFE3A4));}
    } else {
      final left=Paint()..color=const Color(0xFFAF153B),right=Paint()..color=const Color(0xFFE9E9ED);
      canvas.drawPath(Path()..moveTo(0,0)..lineTo(w*.52,0)..lineTo(w*.28,h*.61)..lineTo(0,h*.78)..close(),left..color=const Color(0x667D0B22));
      canvas.drawPath(Path()..moveTo(w,0)..lineTo(w*.52,0)..lineTo(w*.70,h*.61)..lineTo(w,h*.78)..close(),right..color=const Color(0x66D6D9E2));
      _crest(canvas,Offset(w*.29,h*.35),w*.19,const Color(0xFFB31840),'FCB');
      _crest(canvas,Offset(w*.71,h*.35),w*.19,const Color(0xFFECEEF5),'RM');
      canvas.drawLine(Offset(w*.5,h*.13),Offset(w*.5,h*.63),Paint()..color=const Color(0xFFF2B76C)..strokeWidth=2);
    }
  }
  void _crest(Canvas c,Offset center,double radius,Color fill,String label){
    c.drawCircle(center,radius,Paint()..color=const Color(0xFFD6A957));
    c.drawCircle(center,radius*.88,Paint()..color=fill);
    final tp=TextPainter(text:TextSpan(text:label,style:TextStyle(color:label=='FCB'?Colors.white:const Color(0xFF1B3571),fontWeight:FontWeight.w900,fontSize:radius*.63)),textDirection:TextDirection.ltr)..layout();
    tp.paint(c,center-Offset(tp.width/2,tp.height/2));
  }
  @override bool shouldRepaint(covariant CategoryArtworkPainter old)=>old.categoryId!=categoryId;
}
