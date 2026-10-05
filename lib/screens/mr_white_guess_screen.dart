import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'result_screen.dart';

class MrWhiteGuessScreen extends StatefulWidget {
  final int eliminatedPlayerId;

  const MrWhiteGuessScreen({super.key, required this.eliminatedPlayerId});

  @override
  State<MrWhiteGuessScreen> createState() => _MrWhiteGuessScreenState();
}

class _MrWhiteGuessScreenState extends State<MrWhiteGuessScreen> {
  final TextEditingController _guessController = TextEditingController();

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }

  void _checkGuess(BuildContext context, GameState gameState) {
    if (_guessController.text.isEmpty) return;

    bool isCorrect = gameState.checkMrWhiteGuess(_guessController.text);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          eliminatedPlayerId: widget.eliminatedPlayerId,
          mrWhiteGuessedCorrectly: isCorrect,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BrutalCard(
                      backgroundColor: const Color(0xFFfacc15), // Yellow for Mr White
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const FaIcon(FontAwesomeIcons.ghost, size: 80, color: Colors.black),
                          const SizedBox(height: 20),
                          Text(
                            loc.translate('mrwhite_guess_title'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            loc.translate('mrwhite_guess_desc'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: TextField(
                              controller: _guessController,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: loc.translate('mrwhite_guess_hint'),
                                hintStyle: const TextStyle(color: Colors.black38),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    BrutalButton(
                      backgroundColor: const Color(0xFF38bdf8),
                      onPressed: () => _checkGuess(context, gameState),
                      child: Text(loc.translate('check_guess')),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
