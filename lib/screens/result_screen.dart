import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'home_screen.dart';
import 'setup_screen.dart';
import 'speaking_turn_screen.dart';
import 'roulette_screen.dart';

class ResultScreen extends StatelessWidget {
  final int eliminatedPlayerId;
  final bool? mrWhiteGuessedCorrectly;

  const ResultScreen({super.key, required this.eliminatedPlayerId, this.mrWhiteGuessedCorrectly});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<GameState>(
          builder: (context, gameState, child) {
            final player = gameState.players.firstWhere((p) => p.id == eliminatedPlayerId);
            
            String roleName = loc.translate('civilian');
            Color roleColor = const Color(0xFF38bdf8);
            var roleIcon = FontAwesomeIcons.magnifyingGlass;
            
            if (player.role == 'undercover') {
              roleName = loc.translate('undercover');
              roleColor = const Color(0xFFf43f5e);
              roleIcon = FontAwesomeIcons.userSecret;
            } else if (player.role == 'mrwhite') {
              roleName = loc.translate('mrwhite');
              roleColor = const Color(0xFFfacc15);
              roleIcon = FontAwesomeIcons.ghost;
            }

            String winStatus = gameState.checkWinCondition();
            
            // If Mr White guessed correctly, override winStatus to mrwhite_win
            if (mrWhiteGuessedCorrectly == true) {
              winStatus = 'mrwhite_win';
            } else if (mrWhiteGuessedCorrectly == false && winStatus == 'continue') {
              // If Mr White guessed wrong and the game otherwise would continue, check if civilians actually won (all infiltrators dead)
              int aliveUndercovers = gameState.players.where((p) => p.isAlive && p.role == 'undercover').length;
              int aliveMrWhites = gameState.players.where((p) => p.isAlive && p.role == 'mrwhite').length;
              if (aliveUndercovers == 0 && aliveMrWhites == 0) {
                winStatus = 'civilian_win';
              }
            }

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BrutalCard(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: roleColor,
                      child: Column(
                        children: [
                          Text(
                            player.name,
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            color: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(
                              loc.translate('eliminated').toUpperCase(),
                              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${loc.translate('real_role_is')}: ',
                                  style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                FaIcon(roleIcon, size: 24, color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  roleName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (winStatus == 'continue')
                      BrutalButton(
                        backgroundColor: const Color(0xFF4ade80), // Green
                        onPressed: () {
                          gameState.startSpeakingPhase();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SpeakingTurnScreen()),
                          );
                        },
                        child: Text(loc.translate('continue')),
                      )
                    else
                      _buildGameOverDetails(context, gameState, winStatus, loc),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGameOverDetails(BuildContext context, GameState gameState, String winStatus, LocalizationProvider loc) {
    String title;
    Color titleBgColor;
    String desc;

    if (winStatus == 'civilian_win') {
      title = loc.translate('civ_win');
      titleBgColor = const Color(0xFF4ade80); // Green
      desc = loc.translate('civ_win_desc');
    } else if (winStatus == 'undercover_win') {
      title = loc.translate('undercover_win');
      titleBgColor = const Color(0xFFf43f5e); // Red
      desc = loc.translate('undercover_win_desc');
    } else if (winStatus == 'mrwhite_win') {
      title = loc.translate('mrwhite_win');
      titleBgColor = const Color(0xFFfacc15); // Yellow
      desc = loc.translate('mrwhite_win_desc');
    } else { // inf_win
      title = loc.translate('inf_win');
      titleBgColor = const Color(0xFFf97316); // Orange for combined impostors
      desc = loc.translate('inf_win_desc');
    }

    return Column(
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: BrutalCard(
            backgroundColor: titleBgColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${loc.translate("word_civ")}${gameState.currentWords?.civilianWord}',
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${loc.translate("word_und")}${gameState.currentWords?.undercoverWord}',
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        if (gameState.isPunishmentEnabled) ...[
          BrutalButton(
            backgroundColor: const Color(0xFFfacc15),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RouletteScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.rotate, color: Colors.black),
                const SizedBox(width: 10),
                Text(loc.translate('spin_wheel')),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            Expanded(
              flex: 5,
              child: BrutalButton(
                backgroundColor: const Color(0xFF38bdf8),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SetupScreen()),
                    (route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.rotateRight, color: Colors.black),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        loc.translate('play_again'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: BrutalButton(
                backgroundColor: const Color(0xFFd1d5db), // Light Gray
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.house, color: Colors.black),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
