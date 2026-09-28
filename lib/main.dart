import 'package:flutter/material.dart';
import 'game_board.dart';

void main() => runApp(const TriviaGameApp());

class TriviaGameApp extends StatefulWidget {
  const TriviaGameApp({super.key});
  @override State<TriviaGameApp> createState()=>_TriviaGameAppState();
}
class _TriviaGameAppState extends State<TriviaGameApp>{
  Locale? locale;
  @override Widget build(BuildContext context)=>MaterialApp(debugShowCheckedModeBanner:false,theme:ThemeData(useMaterial3:true,brightness:Brightness.dark,scaffoldBackgroundColor:const Color(0xFF080A14),colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF775BFF),brightness:Brightness.dark)),home:locale==null?LanguageGate(onSelected:(v)=>setState(()=>locale=v)):HomeScreen(locale:locale!,changeLanguage:()=>setState(()=>locale=null)));
}

class LanguageGate extends StatelessWidget{
  const LanguageGate({super.key,required this.onSelected}); final ValueChanged<Locale> onSelected;
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Padding(padding:const EdgeInsets.all(24),child:Column(children:[const Spacer(),Container(width:92,height:92,decoration:BoxDecoration(borderRadius:BorderRadius.circular(28),gradient:const LinearGradient(colors:[Color(0xFF775BFF),Color(0xFF23D7CF)])),child:const Icon(Icons.bolt_rounded,size:54)),const SizedBox(height:28),const Text('اختر لغتك  •  Choose your language',textAlign:TextAlign.center,style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:36),_lang('🇦🇪','العربية','ابدأ اللعب بالعربي',()=>onSelected(const Locale('ar'))),const SizedBox(height:14),_lang('🇬🇧','English','Play in English',()=>onSelected(const Locale('en'))),const Spacer(),const Text('200  •  400  •  600')]))));
  Widget _lang(String f,String t,String s,VoidCallback tap)=>InkWell(onTap:tap,borderRadius:BorderRadius.circular(22),child:Ink(padding:const EdgeInsets.all(18),decoration:card(),child:Row(children:[Text(f,style:const TextStyle(fontSize:34)),const SizedBox(width:16),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),Text(s,style:const TextStyle(color:Colors.white54))])),const Icon(Icons.arrow_forward_ios_rounded,size:16)])));
}

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key,required this.locale,required this.changeLanguage});
  final Locale locale;
  final VoidCallback changeLanguage;
  @override Widget build(BuildContext context){
    final ar=locale.languageCode=='ar';
    return Directionality(
      textDirection:ar?TextDirection.rtl:TextDirection.ltr,
      child:Scaffold(
        appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'جاهز للتحدي؟':'Ready to challenge?'),actions:[IconButton(onPressed:changeLanguage,icon:const Icon(Icons.language_rounded))]),
        body:ListView(
          padding:const EdgeInsets.all(20),
          children:[
            Container(
              padding:const EdgeInsets.all(22),
              decoration:BoxDecoration(borderRadius:BorderRadius.circular(28),gradient:const LinearGradient(colors:[Color(0xFF6C4DFF),Color(0xFF241B60)])),
              child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text(ar?'أول لعبة علينا 🎁':'Your first game is on us 🎁',style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
                const SizedBox(height:8),
                Text(ar?'اختاروا الفئات وبعدها اختاروا السؤال والنقاط بأنفسكم.':'Choose categories, then choose the category and points yourselves.'),
                const SizedBox(height:20),
                FilledButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>CategoryScreen(ar:ar))),icon:const Icon(Icons.play_arrow_rounded),label:Text(ar?'كوّن لعبتك':'Build your game')),
              ]),
            ),
            const SizedBox(height:25),
            Text(ar?'الفئات الجاهزة':'Ready categories',style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),
            const SizedBox(height:12),
            Wrap(spacing:10,runSpacing:10,children:[CategoryMini('🇦🇪',ar?'الإمارات':'UAE'),CategoryMini('⚽',ar?'كرة القدم الإماراتية':'UAE Football')]),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget{
  const CategoryScreen({super.key,required this.ar}); final bool ar;
  @override State<CategoryScreen> createState()=>_CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen>{
  final selected=<int>{};
  final search=TextEditingController();
  String query='';
  final cats=const [
    ['🇦🇪','الإمارات','UAE'],
    ['⚽','كرة القدم الإماراتية','UAE Football'],
  ];
  @override void dispose(){search.dispose();super.dispose();}
  List<int> get filteredIndexes{
    final q=query.trim().toLowerCase();
    if(q.isEmpty)return List.generate(cats.length,(i)=>i);
    return List.generate(cats.length,(i)=>i).where((i){final c=cats[i];return c[1].toLowerCase().contains(q)||c[2].toLowerCase().contains(q);}).toList();
  }
  @override Widget build(BuildContext context){
    final ar=widget.ar; final visible=filteredIndexes;
    return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'اصنع المواجهة':'Build the showdown')),body:Column(children:[
      Padding(padding:const EdgeInsets.fromLTRB(20,4,20,10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(ar?'اختر من فئة إلى 6 فئات':'Choose 1 to 6 categories',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(ar?'${selected.length}/6 مختارة':'${selected.length}/6 selected',style:const TextStyle(color:Colors.white60)),const SizedBox(height:14),
        TextField(controller:search,onChanged:(v)=>setState(()=>query=v),textInputAction:TextInputAction.search,decoration:InputDecoration(hintText:ar?'ابحث عن فئة...':'Search categories...',prefixIcon:const Icon(Icons.search_rounded),suffixIcon:query.isEmpty?null:IconButton(onPressed:(){search.clear();setState(()=>query='');},icon:const Icon(Icons.close_rounded)),filled:true,fillColor:Colors.white.withValues(alpha:.06),contentPadding:const EdgeInsets.symmetric(horizontal:16,vertical:14),border:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:BorderSide(color:Colors.white.withValues(alpha:.10))),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:BorderSide(color:Colors.white.withValues(alpha:.10))),focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:const BorderSide(color:Color(0xFFD3A52F),width:1.5))))
      ])),
      Expanded(child:visible.isEmpty?Center(child:Text(ar?'ما حصلنا فئة بهذا الاسم':'No category found',style:const TextStyle(color:Colors.white60,fontSize:16))):GridView.builder(padding:const EdgeInsets.symmetric(horizontal:20),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.05,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:visible.length,itemBuilder:(_,position){final i=visible[position];final on=selected.contains(i);final c=cats[i];return InkWell(onTap:()=>setState((){if(on){selected.remove(i);}else if(selected.length<6){selected.add(i);}}),borderRadius:BorderRadius.circular(24),child:AnimatedContainer(duration:const Duration(milliseconds:180),padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:on?const Color(0xFF6D52E8).withValues(alpha:.30):Colors.white.withValues(alpha:.05),borderRadius:BorderRadius.circular(24),border:Border.all(color:on?const Color(0xFF8E7AFF):Colors.white10,width:on?2:1)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(c[0],style:const TextStyle(fontSize:30)),if(on)const Icon(Icons.check_circle_rounded,color:Color(0xFF8FE8DF))]),const Spacer(),Text(ar?c[1]:c[2],style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(ar?'102 سؤال':'102 questions',style:const TextStyle(color:Color(0xFF8FE8DF))),const SizedBox(height:8),const Text('200 • 200 • 400 • 400 • 600 • 600',style:TextStyle(fontSize:10,color:Colors.white60))])));})) ,
      SafeArea(top:false,child:Padding(padding:const EdgeInsets.all(20),child:SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:selected.isEmpty?null:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>TeamSetup(ar:ar,selectedCategoryIndexes:selected.toList()))),child:Text(ar?'التالي • جهّز الفريقين':'Next • Set up teams',style:const TextStyle(fontWeight:FontWeight.w800))))))
    ])));
  }
}

class TeamSetup extends StatefulWidget{
  const TeamSetup({super.key,required this.ar,required this.selectedCategoryIndexes});final bool ar;final List<int> selectedCategoryIndexes;@override State<TeamSetup> createState()=>_TeamSetupState();
}
class _TeamSetupState extends State<TeamSetup>{
  final a=TextEditingController();final b=TextEditingController();
  @override void dispose(){a.dispose();b.dispose();super.dispose();}
  @override Widget build(BuildContext context){final ar=widget.ar;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent),body:Padding(padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'سمّوا الفريقين':'Name your teams',style:const TextStyle(fontSize:29,fontWeight:FontWeight.w900)),const SizedBox(height:30),TeamField(controller:a,icon:'⚡',label:ar?'الفريق الأول':'Team One'),const SizedBox(height:14),TeamField(controller:b,icon:'🔥',label:ar?'الفريق الثاني':'Team Two'),const Spacer(),Text(ar?'بعد البداية بتظهر لوحة الفئات: 200 / 200 / 400 / 400 / 600 / 600 لكل فئة.':'The board will show 200 / 200 / 400 / 400 / 600 / 600 for each category.',style:const TextStyle(color:Colors.white60)),const SizedBox(height:16),SizedBox(width:double.infinity,height:58,child:FilledButton(onPressed:(){final aa=a.text.trim().isEmpty?(ar?'الفريق الأول':'Team One'):a.text.trim();final bb=b.text.trim().isEmpty?(ar?'الفريق الثاني':'Team Two'):b.text.trim();Navigator.push(context,MaterialPageRoute(builder:(_)=>TriviaBoardScreen(ar:ar,categoryIndexes:widget.selectedCategoryIndexes,teamA:aa,teamB:bb)));},child:Text(ar?'ابدأ المواجهة':'Start the showdown',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900))))]))));}
}
class TeamField extends StatelessWidget{
  const TeamField({super.key,required this.controller,required this.icon,required this.label});final TextEditingController controller;final String icon,label;
  @override Widget build(BuildContext context)=>TextField(controller:controller,decoration:InputDecoration(prefixIcon:Center(widthFactor:1.5,child:Text(icon,style:const TextStyle(fontSize:25))),labelText:label,filled:true,fillColor:Colors.white.withValues(alpha:.05),border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none)));
}
class CategoryMini extends StatelessWidget{
  const CategoryMini(this.e,this.t,{super.key});final String e,t;
  @override Widget build(BuildContext context)=>Container(width:170,padding:const EdgeInsets.all(15),decoration:card(),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(e,style:const TextStyle(fontSize:27)),const SizedBox(height:8),Text(t,style:const TextStyle(fontWeight:FontWeight.w800)),const SizedBox(height:3),const Text('102',style:TextStyle(color:Color(0xFF8FE8DF)))]));
}
BoxDecoration card()=>BoxDecoration(color:Colors.white.withValues(alpha:.055),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.09)));
