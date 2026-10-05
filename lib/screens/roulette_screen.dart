import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../services/analytics_service.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  StreamController<int> selected = StreamController<int>();
  bool _isSpinning = false;
  
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _showResultDialog(String punishment, LocalizationProvider loc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(0),
          ),
          title: Text(
            loc.translate('punishment_result'),
            style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: Text(
            punishment,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          actions: [
            BrutalButton(
              backgroundColor: const Color(0xFF38bdf8),
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // close roulette screen back to result screen
              },
              child: Text(loc.translate('close')),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    final loc = Provider.of<LocalizationProvider>(context);
    final items = gameState.customPunishments.isEmpty 
        ? ["N/A"] 
        : gameState.customPunishments;

    return Scaffold(
      backgroundColor: const Color(0xFFf3f4f6),
      appBar: AppBar(
        title: Text(loc.translate('enable_punishment'), style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  loc.translate('roulette_intro'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FortuneWheel(
                      selected: selected.stream,
                      animateFirst: false,
                      indicators: const <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: TriangleIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ],
                      items: [
                        for (var it in items) 
                          FortuneItem(
                            child: Text(
                              it, 
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                      onAnimationEnd: () {
                        setState(() => _isSpinning = false);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BrutalButton(
                backgroundColor: const Color(0xFFfacc15),
                onPressed: _isSpinning || items.length < 2 ? null : () {
                  AnalyticsService().logEvent('wheel_spun');
                  setState(() => _isSpinning = true);
                  int nextIndex = Fortune.randomInt(0, items.length);
                  selected.add(nextIndex);
                  
                  // Fortune wheel animation defaults to 5s. Wait before showing result.
                  Future.delayed(const Duration(seconds: 5), () {
                    if (mounted) {
                      _showResultDialog(items[nextIndex], loc);
                    }
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(FontAwesomeIcons.rotate, color: Colors.black),
                    const SizedBox(width: 10),
                    Text(loc.translate('spin_wheel')),
                  ],
                ),
              ),
              if (items.length < 2)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("Needs at least 2 punishments to spin", style: TextStyle(color: Colors.red)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
