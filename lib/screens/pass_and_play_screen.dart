import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'speaking_turn_screen.dart';

class PassAndPlayScreen extends StatefulWidget {
  const PassAndPlayScreen({super.key});

  @override
  State<PassAndPlayScreen> createState() => _PassAndPlayScreenState();
}

class _PassAndPlayScreenState extends State<PassAndPlayScreen> {
  bool _isRevealed = false;

  void _nextTurn(GameState gameState) {
    setState(() {
      _isRevealed = false;
    });
    
    gameState.nextPlayerTurn();
    
    if (gameState.isPassAndPlayFinished()) {
      gameState.startSpeakingPhase();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SpeakingTurnScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            if (gameState.isPassAndPlayFinished()) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentPlayer = gameState.currentPlayer;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeInBack,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: !_isRevealed 
                    ? _buildPassState(currentPlayer.name, loc)
                    : _buildRevealState(currentPlayer, gameState, loc),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPassState(String playerName, LocalizationProvider loc) {
    return SizedBox(
      key: const ValueKey(false),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.handPointRight, size: 80, color: Colors.black),
          const SizedBox(height: 20),
          Text(
            loc.translate('pass_to'),
            style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          BrutalCard(
            backgroundColor: const Color(0xFFfacc15),
            child: Text(
              playerName,
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          BrutalButton(
            backgroundColor: const Color(0xFF38bdf8),
            onPressed: () {
              setState(() {
                _isRevealed = true;
              });
            },
            child: Text(loc.translate('view_word'), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildRevealState(Player currentPlayer, GameState gameState, LocalizationProvider loc) {
    Color cardColor = currentPlayer.role == 'mrwhite' ? const Color(0xFFfacc15) : const Color(0xFF38bdf8);

    return SizedBox(
      key: const ValueKey(true),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loc.translate('your_word_is'),
            style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          BrutalCard(
            padding: const EdgeInsets.all(40),
            backgroundColor: cardColor,
            child: Column(
              children: [
                FaIcon(
                  currentPlayer.role == 'mrwhite' ? FontAwesomeIcons.ghost : FontAwesomeIcons.eye,
                  size: 70,
                  color: Colors.black,
                ),
                const SizedBox(height: 30),
                Text(
                  currentPlayer.word,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: currentPlayer.role == 'mrwhite' ? 24 : 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    currentPlayer.role == 'mrwhite' ? loc.translate('mrwhite') : loc.translate('keep_secret'),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 60),
          BrutalButton(
            backgroundColor: const Color(0xFF4ade80), // Green
            onPressed: () => _nextTurn(gameState),
            child: Text(loc.translate('remembered_word'), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          Text(
            loc.translate('dont_show'), 
            style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
