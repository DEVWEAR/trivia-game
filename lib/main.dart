import 'dart:async';
import 'dart:math';
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
          imageTimer=Timer.periodic(const Duration(seconds:7),(_){
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
class _CategoryScreenState extends State<CategoryScreen>{final selected=<int>{};final search=TextEditingController();String query='';final cats=playableCategories.map((c)=><String>[c.icon,c.ar,c.en]).toList();@override void dispose(){search.dispose();super.dispose();}List<int> get filteredIndexes{final q=query.trim().toLowerCase();if(q.isEmpty)return List.generate(cats.length,(i)=>i);return List.generate(cats.length,(i)=>i).where((i)=>cats[i][1].toLowerCase().contains(q)||cats[i][2].toLowerCase().contains(q)).toList();}@override Widget build(BuildContext context){final ar=widget.ar;final visible=filteredIndexes;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'اصنع المواجهة':'Build the showdown')),body:Column(children:[Expanded(child:ListView(children:[Padding(padding:const EdgeInsets.fromLTRB(20,4,20,10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'اختر من فئة إلى 6 فئات':'Choose 1 to 6 categories',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(ar?'${selected.length}/6 مختارة':'${selected.length}/6 selected',style:const TextStyle(color:Colors.white60)),const SizedBox(height:14),TextField(controller:search,onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(hintText:ar?'ابحث عن فئة...':'Search categories...',prefixIcon:const Icon(Icons.search_rounded),filled:true,fillColor:Colors.white.withValues(alpha:.06),border:OutlineInputBorder(borderRadius:BorderRadius.circular(18))))])),GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),padding:const EdgeInsets.symmetric(horizontal:20),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.05,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:visible.length,itemBuilder:(_,p){final i=visible[p],c=cats[i];final on=selected.contains(i);return InkWell(onTap:()=>setState((){if(on){selected.remove(i);}else if(selected.length<6){selected.add(i);}}),borderRadius:BorderRadius.circular(24),child:Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:on?const Color(0xFF064652).withValues(alpha:.30):Colors.white.withValues(alpha:.05),borderRadius:BorderRadius.circular(24),border:Border.all(color:on?const Color(0xFFC99A58):Colors.white10)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(c[0],style:const TextStyle(fontSize:30)),const Spacer(),Text(ar?c[1]:c[2],style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(ar?'${playableCategories[i].questions.length} بطاقة':'${playableCategories[i].questions.length} cards',style:const TextStyle(color:Color(0xFFC99A58))),])));})])),SafeArea(top:false,child:Padding(padding:const EdgeInsets.all(20),child:SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:selected.isEmpty?null:(){final fresh=selected.toList()..shuffle(Random(DateTime.now().microsecondsSinceEpoch));Navigator.push(context,MaterialPageRoute(builder:(_)=>TeamSetup(ar:ar,selectedCategoryIndexes:fresh)));},child:Text(ar?'التالي • جهّز الفريقين':'Next • Set up teams'))))) ])));}}
class TeamSetup extends StatefulWidget{const TeamSetup({super.key,required this.ar,required this.selectedCategoryIndexes});final bool ar;final List<int> selectedCategoryIndexes;@override State<TeamSetup> createState()=>_TeamSetupState();}
class _TeamSetupState extends State<TeamSetup>{final a=TextEditingController(),b=TextEditingController();@override void dispose(){a.dispose();b.dispose();super.dispose();}@override Widget build(BuildContext context){final ar=widget.ar;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent),body:Padding(padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'سمّوا الفريقين':'Name your teams',style:const TextStyle(fontSize:29,fontWeight:FontWeight.w900)),const SizedBox(height:30),TeamField(controller:a,icon:'⚡',label:ar?'الفريق الأول':'Team One'),const SizedBox(height:14),TeamField(controller:b,icon:'🔥',label:ar?'الفريق الثاني':'Team Two'),const Spacer(),SizedBox(width:double.infinity,height:58,child:FilledButton(onPressed:(){final aa=a.text.trim().isEmpty?(ar?'الفريق الأول':'Team One'):a.text.trim(),bb=b.text.trim().isEmpty?(ar?'الفريق الثاني':'Team Two'):b.text.trim();final seed=DateTime.now().microsecondsSinceEpoch;for(final i in widget.selectedCategoryIndexes){categoryForIndex(i).questions.shuffle(Random(seed^(i+1)*7919));}final freshIndexes=List<int>.of(widget.selectedCategoryIndexes)..shuffle(Random(seed));Navigator.push(context,MaterialPageRoute(builder:(_)=>TriviaBoardScreen(key:ValueKey(seed),ar:ar,categoryIndexes:freshIndexes,teamA:aa,teamB:bb)));},child:Text(ar?'ابدأ المواجهة':'Start the showdown',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900))))]))));}}
class TeamField extends StatelessWidget{const TeamField({super.key,required this.controller,required this.icon,required this.label});final TextEditingController controller;final String icon,label;@override Widget build(BuildContext context)=>TextField(controller:controller,decoration:InputDecoration(prefixIcon:Center(widthFactor:1.5,child:Text(icon,style:const TextStyle(fontSize:25))),labelText:label,filled:true,fillColor:Colors.white.withValues(alpha:.05),border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none)));}
BoxDecoration card()=>BoxDecoration(color:Colors.white.withValues(alpha:.055),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.09)));
