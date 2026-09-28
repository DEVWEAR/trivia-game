import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_board.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(TriviaGameApp(savedLocale: prefs.getString('locale')));
}

class TriviaGameApp extends StatefulWidget {
  const TriviaGameApp({super.key, this.savedLocale});
  final String? savedLocale;
  @override State<TriviaGameApp> createState() => _TriviaGameAppState();
}
class _TriviaGameAppState extends State<TriviaGameApp> {
  Locale? locale;
  @override void initState(){super.initState();if(widget.savedLocale!=null)locale=Locale(widget.savedLocale!);}
  Future<void> _setLocale(Locale? value) async {final prefs=await SharedPreferences.getInstance();if(value==null){await prefs.remove('locale');}else{await prefs.setString('locale',value.languageCode);}if(mounted)setState(()=>locale=value);}
  @override Widget build(BuildContext context)=>MaterialApp(debugShowCheckedModeBanner:false,theme:ThemeData(useMaterial3:true,brightness:Brightness.dark,scaffoldBackgroundColor:const Color(0xFF080A14),colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF775BFF),brightness:Brightness.dark)),home:locale==null?LanguageGate(onSelected:_setLocale):HomeScreen(locale:locale!,changeLanguage:()=>_setLocale(null)));
}

class LanguageGate extends StatelessWidget {
  const LanguageGate({super.key,required this.onSelected});final ValueChanged<Locale> onSelected;
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Padding(padding:const EdgeInsets.all(24),child:Column(children:[const Spacer(),Container(width:92,height:92,decoration:BoxDecoration(borderRadius:BorderRadius.circular(28),gradient:const LinearGradient(colors:[Color(0xFF775BFF),Color(0xFF23D7CF)])),child:const Icon(Icons.bolt_rounded,size:54)),const SizedBox(height:28),const Text('اختر لغتك  •  Choose your language',textAlign:TextAlign.center,style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:36),_lang('🇦🇪','العربية','ابدأ اللعب بالعربي',()=>onSelected(const Locale('ar'))),const SizedBox(height:14),_lang('🇬🇧','English','Play in English',()=>onSelected(const Locale('en'))),const Spacer(),const Text('200  •  400  •  600')]))));
  Widget _lang(String f,String t,String s,VoidCallback tap)=>InkWell(onTap:tap,borderRadius:BorderRadius.circular(22),child:Ink(padding:const EdgeInsets.all(18),decoration:card(),child:Row(children:[Text(f,style:const TextStyle(fontSize:34)),const SizedBox(width:16),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),Text(s,style:const TextStyle(color:Colors.white54))])),const Icon(Icons.arrow_forward_ios_rounded,size:16)])));
}

class HomeScreen extends StatefulWidget {const HomeScreen({super.key,required this.locale,required this.changeLanguage});final Locale locale;final VoidCallback changeLanguage;@override State<HomeScreen> createState()=>_HomeScreenState();}
class _HomeScreenState extends State<HomeScreen> {
  bool restoring=true;
  @override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_)=>_restoreRoute());}
  Future<void> _restoreRoute() async {final prefs=await SharedPreferences.getInstance();final stage=prefs.getString('stage')??'home';if(!mounted)return;setState(()=>restoring=false);final ar=widget.locale.languageCode=='ar';final indexes=prefs.getStringList('selected_categories')?.map(int.parse).toList()??<int>[];if(stage=='categories'){Navigator.push(context,MaterialPageRoute(builder:(_)=>CategoryScreen(ar:ar)));}else if(stage=='teams'&&indexes.isNotEmpty){Navigator.push(context,MaterialPageRoute(builder:(_)=>TeamSetup(ar:ar,selectedCategoryIndexes:indexes)));}else if(stage=='board'&&indexes.isNotEmpty){final a=prefs.getString('team_a')??(ar?'الفريق الأول':'Team One');final b=prefs.getString('team_b')??(ar?'الفريق الثاني':'Team Two');Navigator.push(context,MaterialPageRoute(builder:(_)=>TriviaBoardScreen(ar:ar,categoryIndexes:indexes,teamA:a,teamB:b)));}}
  Future<void> _openCategories() async {final prefs=await SharedPreferences.getInstance();await prefs.setString('stage','categories');if(mounted)Navigator.push(context,MaterialPageRoute(builder:(_)=>CategoryScreen(ar:widget.locale.languageCode=='ar')));}
  @override Widget build(BuildContext context){final ar=widget.locale.languageCode=='ar';return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'جاهز للتحدي؟':'Ready to challenge?'),actions:[IconButton(onPressed:widget.changeLanguage,icon:const Icon(Icons.language_rounded))]),body:restoring?const Center(child:CircularProgressIndicator()):ListView(padding:const EdgeInsets.all(20),children:[Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(borderRadius:BorderRadius.circular(28),gradient:const LinearGradient(colors:[Color(0xFF6C4DFF),Color(0xFF241B60)])),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'أول لعبة علينا 🎁':'Your first game is on us 🎁',style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:8),Text(ar?'اختاروا الفئات وبعدها اختاروا السؤال والنقاط بأنفسكم.':'Choose categories, then choose the category and points yourselves.'),const SizedBox(height:20),FilledButton.icon(onPressed:_openCategories,icon:const Icon(Icons.play_arrow_rounded),label:Text(ar?'كوّن لعبتك':'Build your game'))])),const SizedBox(height:28),Text(ar?'كل سؤال يغيّر المواجهة.':'Every question can change the game.',style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:7),Text(ar?'اختاروا بذكاء، اجمعوا النقاط، ولا تعطون خصمكم فرصة يسرقها.':'Choose wisely, collect points, and don’t give your rivals a chance to steal them.',style:const TextStyle(fontSize:15,height:1.5,color:Colors.white70)),const SizedBox(height:18),Row(children:[Expanded(child:_HomeFeature(icon:Icons.timer_outlined,title:ar?'60 ثانية':'60 seconds',subtitle:ar?'جاوب قبل انتهاء الوقت':'Answer before time runs out')),const SizedBox(width:10),Expanded(child:_HomeFeature(icon:Icons.bolt_rounded,title:ar?'سرقة النقاط':'Steal points',subtitle:ar?'15 ثانية تقلب النتيجة':'15 seconds can flip the score'))]),const SizedBox(height:10),Container(padding:const EdgeInsets.symmetric(horizontal:18,vertical:17),decoration:BoxDecoration(color:const Color(0xFF151721),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white12)),child:Row(children:[const Icon(Icons.groups_2_rounded,size:31,color:Color(0xFFD3A52F)),const SizedBox(width:14),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'فريق ضد فريق':'Team vs Team',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900)),const SizedBox(height:3),Text(ar?'200 • 400 • 600 — أنتم تختارون طريق الفوز.':'200 • 400 • 600 — you choose your path to victory.',style:const TextStyle(fontSize:13,color:Colors.white60))]))]))]))));}
}
class _HomeFeature extends StatelessWidget {const _HomeFeature({required this.icon,required this.title,required this.subtitle});final IconData icon;final String title,subtitle;@override Widget build(BuildContext context)=>Container(height:142,padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:const Color(0xFF151721),borderRadius:BorderRadius.circular(22),border:Border.all(color:Colors.white12)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:const Color(0xFFD3A52F),size:27),const Spacer(),Text(title,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(subtitle,maxLines:2,style:const TextStyle(fontSize:12,height:1.25,color:Colors.white54))]));}

class CategoryScreen extends StatefulWidget {const CategoryScreen({super.key,required this.ar});final bool ar;@override State<CategoryScreen> createState()=>_CategoryScreenState();}
class _CategoryScreenState extends State<CategoryScreen> {
  final selected=<int>{};final search=TextEditingController();String query='';final cats=const [['🇦🇪','الإمارات','UAE'],['⚽','كرة القدم الإماراتية','UAE Football']];
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {final prefs=await SharedPreferences.getInstance();final saved=prefs.getStringList('selected_categories')??[];if(mounted)setState(()=>selected.addAll(saved.map(int.parse)));}
  Future<void> _saveSelection() async {final prefs=await SharedPreferences.getInstance();await prefs.setStringList('selected_categories',selected.map((e)=>'$e').toList());}
  @override void dispose(){search.dispose();super.dispose();}
  List<int> get filteredIndexes {final q=query.trim().toLowerCase();if(q.isEmpty)return List.generate(cats.length,(i)=>i);return List.generate(cats.length,(i)=>i).where((i)=>cats[i][1].toLowerCase().contains(q)||cats[i][2].toLowerCase().contains(q)).toList();}
  Future<void> _next() async {await _saveSelection();final prefs=await SharedPreferences.getInstance();await prefs.setString('stage','teams');if(mounted)Navigator.push(context,MaterialPageRoute(builder:(_)=>TeamSetup(ar:widget.ar,selectedCategoryIndexes:selected.toList())));}
  @override Widget build(BuildContext context){
    final ar=widget.ar;final visible=filteredIndexes;
    return Directionality(
      textDirection:ar?TextDirection.rtl:TextDirection.ltr,
      child:Scaffold(
        appBar:AppBar(backgroundColor:Colors.transparent,title:Text(ar?'اصنع المواجهة':'Build the showdown')),
        body:Column(children:[
          Padding(padding:const EdgeInsets.fromLTRB(20,4,20,10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(ar?'اختر من فئة إلى 6 فئات':'Choose 1 to 6 categories',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),
            const SizedBox(height:5),
            Text(ar?'${selected.length}/6 مختارة':'${selected.length}/6 selected',style:const TextStyle(color:Colors.white60)),
            const SizedBox(height:14),
            TextField(controller:search,onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(hintText:ar?'ابحث عن فئة...':'Search categories...',prefixIcon:const Icon(Icons.search_rounded),filled:true,fillColor:Colors.white.withValues(alpha:.06),border:OutlineInputBorder(borderRadius:BorderRadius.circular(18)))),
          ])),
          Expanded(
            child:GridView.builder(
              padding:const EdgeInsets.symmetric(horizontal:20),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.05,crossAxisSpacing:12,mainAxisSpacing:12),
              itemCount:visible.length,
              itemBuilder:(_,p){
                final i=visible[p];final on=selected.contains(i);final c=cats[i];
                return InkWell(
                  onTap:() async {setState((){if(on){selected.remove(i);}else if(selected.length<6){selected.add(i);}});await _saveSelection();},
                  borderRadius:BorderRadius.circular(24),
                  child:Container(
                    padding:const EdgeInsets.all(16),
                    decoration:BoxDecoration(color:on?const Color(0xFF6D52E8).withValues(alpha:.30):Colors.white.withValues(alpha:.05),borderRadius:BorderRadius.circular(24),border:Border.all(color:on?const Color(0xFF8E7AFF):Colors.white10)),
                    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                      Text(c[0],style:const TextStyle(fontSize:30)),
                      const Spacer(),
                      Text(ar?c[1]:c[2],style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800)),
                      const SizedBox(height:5),
                      Text(ar?'102 سؤال':'102 questions',style:const TextStyle(color:Color(0xFF8FE8DF))),
                      const SizedBox(height:8),
                      const Text('200 • 200 • 400 • 400 • 600 • 600',style:TextStyle(fontSize:10,color:Colors.white60)),
                    ]),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top:false,
            child:Padding(
              padding:const EdgeInsets.all(20),
              child:SizedBox(
                width:double.infinity,
                height:56,
                child:FilledButton(onPressed:selected.isEmpty?null:_next,child:Text(ar?'التالي • جهّز الفريقين':'Next • Set up teams')),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class TeamSetup extends StatefulWidget {const TeamSetup({super.key,required this.ar,required this.selectedCategoryIndexes});final bool ar;final List<int> selectedCategoryIndexes;@override State<TeamSetup> createState()=>_TeamSetupState();}
class _TeamSetupState extends State<TeamSetup> {
  final a=TextEditingController();final b=TextEditingController();
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {final prefs=await SharedPreferences.getInstance();a.text=prefs.getString('team_a')??'';b.text=prefs.getString('team_b')??'';}
  Future<void> _start() async {final aa=a.text.trim().isEmpty?(widget.ar?'الفريق الأول':'Team One'):a.text.trim();final bb=b.text.trim().isEmpty?(widget.ar?'الفريق الثاني':'Team Two'):b.text.trim();final prefs=await SharedPreferences.getInstance();await prefs.setStringList('selected_categories',widget.selectedCategoryIndexes.map((e)=>'$e').toList());await prefs.setString('team_a',aa);await prefs.setString('team_b',bb);await prefs.setString('stage','board');if(mounted)Navigator.push(context,MaterialPageRoute(builder:(_)=>TriviaBoardScreen(ar:widget.ar,categoryIndexes:widget.selectedCategoryIndexes,teamA:aa,teamB:bb)));}
  @override void dispose(){a.dispose();b.dispose();super.dispose();}
  @override Widget build(BuildContext context){final ar=widget.ar;return Directionality(textDirection:ar?TextDirection.rtl:TextDirection.ltr,child:Scaffold(appBar:AppBar(backgroundColor:Colors.transparent),body:Padding(padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(ar?'سمّوا الفريقين':'Name your teams',style:const TextStyle(fontSize:29,fontWeight:FontWeight.w900)),const SizedBox(height:30),TeamField(controller:a,icon:'⚡',label:ar?'الفريق الأول':'Team One'),const SizedBox(height:14),TeamField(controller:b,icon:'🔥',label:ar?'الفريق الثاني':'Team Two'),const Spacer(),Text(ar?'بعد البداية بتظهر لوحة الفئات: 200 / 200 / 400 / 400 / 600 / 600 لكل فئة.':'The board will show 200 / 200 / 400 / 400 / 600 / 600 for each category.',style:const TextStyle(color:Colors.white60)),const SizedBox(height:16),SizedBox(width:double.infinity,height:58,child:FilledButton(onPressed:_start,child:Text(ar?'ابدأ المواجهة':'Start the showdown',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900))))]))));}
}
class TeamField extends StatelessWidget {const TeamField({super.key,required this.controller,required this.icon,required this.label});final TextEditingController controller;final String icon,label;@override Widget build(BuildContext context)=>TextField(controller:controller,decoration:InputDecoration(prefixIcon:Center(widthFactor:1.5,child:Text(icon,style:const TextStyle(fontSize:25))),labelText:label,filled:true,fillColor:Colors.white.withValues(alpha:.05),border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none)));}
BoxDecoration card()=>BoxDecoration(color:Colors.white.withValues(alpha:.055),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.09)));
