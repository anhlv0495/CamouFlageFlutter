import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'discussion_and_vote_screen.dart';

class SpeakingTurnScreen extends StatelessWidget {
  const SpeakingTurnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            final aliveUndercovers = gameState.players.where((p) => p.isAlive && p.role == 'undercover').length;
            final aliveMrWhites = gameState.players.where((p) => p.isAlive && p.role == 'mrwhite').length;
            final totalInfiltrators = aliveUndercovers + aliveMrWhites;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top info card
                        BrutalCard(
                          backgroundColor: const Color(0xFFa855f7), // Purple
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                loc.translate('give_clue'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                color: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.userSecret, color: Colors.white, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      '$totalInfiltrators Kẻ Xâm Nhập',
                                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Grid of players
                        Wrap(
                          spacing: 15,
                          runSpacing: 25,
                          alignment: WrapAlignment.center,
                          children: List.generate(gameState.speakingOrder.length, (index) {
                            final player = gameState.speakingOrder[index];
                            // Get initials
                            String initial = player.name.isNotEmpty ? player.name[0].toUpperCase() : '?';

                            return SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // Player circle avatar (Brutalist style)
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4ade80), // Bright green
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
                                      // Speaking order badge
                                      Positioned(
                                        top: -10,
                                        right: -10,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFfacc15), // Yellow
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.black, width: 2),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  // Player name badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BrutalButton(
                    backgroundColor: const Color(0xFF38bdf8),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const DiscussionAndVoteScreen()),
                      );
                    },
                    child: Text(loc.translate('discussion_vote'), textAlign: TextAlign.center),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
