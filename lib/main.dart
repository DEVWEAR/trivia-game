import 'package:flutter/material.dart';

void main() => runApp(const TriviaGameApp());

class TriviaGameApp extends StatefulWidget {
  const TriviaGameApp({super.key});

  @override
  State<TriviaGameApp> createState() => _TriviaGameAppState();
}

class _TriviaGameAppState extends State<TriviaGameApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivia Game',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090B16),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFF),
          brightness: Brightness.dark,
        ),
      ),
      home: _locale == null
          ? LanguageGate(onSelected: (locale) => setState(() => _locale = locale))
          : HomeScreen(
              locale: _locale!,
              onChangeLanguage: () => setState(() => _locale = null),
            ),
    );
  }
}

class LanguageGate extends StatelessWidget {
  const LanguageGate({super.key, required this.onSelected});
  final ValueChanged<Locale> onSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C5CFF), Color(0xFF25D9D0)],
                  ),
                ),
                child: const Icon(Icons.bolt_rounded, size: 54, color: Colors.white),
              ),
              const SizedBox(height: 28),
              const Text(
                'اختر لغتك  •  Choose your language',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(
                'يمكنك تغييرها لاحقاً  •  You can change it later',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: .6)),
              ),
              const SizedBox(height: 38),
              _LanguageCard(
                flag: '🇦🇪',
                title: 'العربية',
                subtitle: 'ابدأ اللعب بالعربي',
                onTap: () => onSelected(const Locale('ar')),
              ),
              const SizedBox(height: 14),
              _LanguageCard(
                flag: '🇬🇧',
                title: 'English',
                subtitle: 'Play in English',
                onTap: () => onSelected(const Locale('en')),
              ),
              const Spacer(),
              const Text('Original social trivia • 200 / 400 / 600'),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({required this.flag, required this.title, required this.subtitle, required this.onTap});
  final String flag;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .06),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withValues(alpha: .10)),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 34)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: .55))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 17),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.locale, required this.onChangeLanguage});
  final Locale locale;
  final VoidCallback onChangeLanguage;

  @override
  Widget build(BuildContext context) {
    final ar = locale.languageCode == 'ar';
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(ar ? 'جاهز للتحدي؟' : 'Ready to challenge?'),
          actions: [
            IconButton(onPressed: onChangeLanguage, icon: const Icon(Icons.language_rounded)),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(colors: [Color(0xFF6B4EFF), Color(0xFF2A1E68)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ar ? 'أول لعبة علينا 🎁' : 'Your first game is on us 🎁',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(ar ? 'اختر فئاتك، كوّن فريقين وابدأ.' : 'Pick categories, make two teams, and play.'),
                  const SizedBox(height: 22),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(ar ? 'ابدأ لعبة' : 'Start game'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(ar ? 'فئات مقترحة' : 'Featured categories', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _CategoryChip('🇦🇪', 'UAE', '100/100'),
                _CategoryChip('⚽', 'Football', '100/100'),
                _CategoryChip('🐆', 'Animals', '100/100'),
                _CategoryChip('🌍', 'World', '100/100'),
                _CategoryChip('🎮', 'Gaming', '100/100'),
                _CategoryChip('🧠', 'Brain', '100/100'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(this.emoji, this.title, this.remaining);
  final String emoji;
  final String title;
  final String remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .055),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(remaining, style: const TextStyle(color: Color(0xFF8FE8DF))),
        ],
      ),
    );
  }
}
