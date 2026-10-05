import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'result_screen.dart';
import 'mr_white_guess_screen.dart';

class DiscussionAndVoteScreen extends StatelessWidget {
  const DiscussionAndVoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('discussion_vote'), style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            final alivePlayers = gameState.alivePlayers;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: [
                        BrutalCard(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: const Color(0xFFfacc15), // Yellow
                          child: Column(
                            children: [
                              Text(
                                loc.translate('discussion_desc'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                color: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Text(
                                  loc.translate('choose_to_eliminate'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          spacing: 20,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: List.generate(alivePlayers.length, (index) {
                            final player = alivePlayers[index];
                            String initial = player.name.isNotEmpty ? player.name[0].toUpperCase() : '?';

                            return GestureDetector(
                              onTap: () {
                                _confirmVote(context, gameState, player.id, player.name, loc);
                              },
                              child: SizedBox(
                                width: 100,
                                child: Column(
                                  children: [
                                    // Player Avatar
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 3),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(4, 4),
                                            blurRadius: 0,
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        initial,
                                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    // Player Name
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFf43f5e), // Pink/Red indicating eliminate action
                                        border: Border.all(color: Colors.black, width: 2),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        player.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _confirmVote(BuildContext context, GameState gameState, int playerId, String playerName, LocalizationProvider loc) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: BrutalCard(
          padding: const EdgeInsets.all(30),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.translate('confirm'),
                style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),
              Text(
                '${loc.translate("sure_to_eliminate")} $playerName?',
                style: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(loc.translate('cancel'), style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  BrutalButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: const Color(0xFFf43f5e),
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      
                      final eliminatedPlayer = gameState.players.firstWhere((p) => p.id == playerId);
                      gameState.eliminatePlayer(playerId);
                      
                      if (eliminatedPlayer.role == 'mrwhite') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MrWhiteGuessScreen(eliminatedPlayerId: playerId),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(eliminatedPlayerId: playerId),
                          ),
                        );
                      }
                    },
                    child: Text(loc.translate('eliminate'), style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
