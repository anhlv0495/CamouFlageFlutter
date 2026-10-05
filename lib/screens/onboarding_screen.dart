import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'home_screen.dart';
import '../services/analytics_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    
    AnalyticsService().logEvent('onboarding_completed');

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    final List<Map<String, dynamic>> pages = [
      {
        'icon': FontAwesomeIcons.users,
        'color': const Color(0xFF38bdf8),
        'title': loc.translate('onboarding_title_1'),
        'desc': loc.translate('onboarding_desc_1'),
      },
      {
        'icon': FontAwesomeIcons.magnifyingGlass,
        'color': const Color(0xFFa855f7),
        'title': loc.translate('onboarding_title_2'),
        'desc': loc.translate('onboarding_desc_2'),
      },
      {
        'icon': FontAwesomeIcons.userSecret,
        'color': const Color(0xFFf43f5e),
        'title': loc.translate('onboarding_title_3'),
        'desc': loc.translate('onboarding_desc_3'),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BrutalCard(
                          backgroundColor: pages[index]['color'],
                          borderRadius: 100,
                          padding: const EdgeInsets.all(40),
                          child: FaIcon(
                            pages[index]['icon'],
                            size: 100,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Text(
                          pages[index]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          pages[index]['desc'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.black26,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: BrutalButton(
                backgroundColor: const Color(0xFFfacc15),
                onPressed: _onNext,
                child: Text(
                  _currentPage == pages.length - 1
                      ? loc.translate('start_playing')
                      : loc.translate('continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
