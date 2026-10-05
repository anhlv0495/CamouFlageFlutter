import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'setup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/analytics_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Language Switcher
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PopupMenuButton<String>(
                  onSelected: (String lang) {
                    loc.setLanguage(lang);
                    AnalyticsService().logEvent('language_selected', parameters: {'language': lang});
                  },
                  offset: const Offset(0, 50),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'vi',
                      child: Text('VI - Tiếng Việt', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'en',
                      child: Text('EN - English', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'es',
                      child: Text('ES - Español', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'zh',
                      child: Text('ZH - 中文', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                  ],
                  child: BrutalCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    backgroundColor: const Color(0xFFfacc15), // Yellow
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(FontAwesomeIcons.globe, color: Colors.black, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          loc.currentLang.toUpperCase(),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        const FaIcon(FontAwesomeIcons.chevronDown, color: Colors.black, size: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BrutalCard(
                        backgroundColor: const Color(0xFF38bdf8), // Light Blue
                        borderRadius: 100, // Make it circular
                        padding: const EdgeInsets.all(30),
                        child: const FaIcon(FontAwesomeIcons.userSecret, size: 100, color: Colors.black),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        loc.translate('game_title'),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        loc.translate('game_subtitle'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 60),
                      BrutalButton(
                        backgroundColor: const Color(0xFFa855f7), // Purple
                        onPressed: () {
                          AnalyticsService().logEvent('play_now_clicked');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SetupScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                          child: Text(loc.translate('play_now'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BrutalButton(
                        backgroundColor: const Color(0xFFf97316), // Orange
                        onPressed: () {
                          AnalyticsService().logEvent('rules_viewed');
                          _showRules(context, loc);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(FontAwesomeIcons.circleQuestion, color: Colors.black, size: 20),
                            const SizedBox(width: 8),
                            Text(loc.translate('rules')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRules(BuildContext context, LocalizationProvider loc) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: BrutalCard(
          backgroundColor: const Color(0xFFfdf6e3),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.translate('rules_title'),
                style: const TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),
              Text(
                loc.translate('rules_content'),
                style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              BrutalButton(
                backgroundColor: const Color(0xFF38bdf8),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                onPressed: () => Navigator.pop(context),
                child: Text(loc.translate('understood')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
