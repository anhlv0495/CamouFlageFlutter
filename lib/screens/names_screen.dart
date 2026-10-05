import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'pass_and_play_screen.dart';

class NamesScreen extends StatelessWidget {
  const NamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('enter_names'), style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: gameState.players.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: BrutalCard(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            backgroundColor: Colors.white,
                            child: TextFormField(
                              initialValue: (gameState.players[index].name.startsWith('Người chơi') || gameState.players[index].name.startsWith('Player')) 
                                  ? '' 
                                  : gameState.players[index].name,
                              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                              decoration: InputDecoration(
                                labelText: '${loc.translate("player")} ${index + 1}',
                                labelStyle: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.edit, color: Colors.black),
                              ),
                              onChanged: (value) {
                                gameState.updatePlayerName(index, value.isEmpty ? '${loc.translate("player")} ${index + 1}' : value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: BrutalButton(
                      backgroundColor: const Color(0xFFa855f7),
                      onPressed: () {
                        gameState.startGame(loc.currentLang, loc.translate('player'), loc.translate('mrwhite_word'));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const PassAndPlayScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        loc.translate('start_game'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
