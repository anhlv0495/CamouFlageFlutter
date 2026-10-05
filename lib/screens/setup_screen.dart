import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/game_state.dart';
import '../models/localization_provider.dart';
import '../widgets/brutal_button.dart';
import '../widgets/brutal_card.dart';
import 'names_screen.dart';
import '../services/analytics_service.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('setup_title'), style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRoleRow(
                    title: loc.translate('civilian'),
                    subtitle: loc.translate('civilian_desc'),
                    count: gameState.civilianCount,
                    color: const Color(0xFF38bdf8),
                    iconData: FontAwesomeIcons.magnifyingGlass,
                    onMinus: () => gameState.updateRoleCount('civilian', -1),
                    onPlus: () => gameState.updateRoleCount('civilian', 1),
                  ),
                  const SizedBox(height: 20),
                  _buildRoleRow(
                    title: loc.translate('undercover'),
                    subtitle: loc.translate('undercover_desc'),
                    count: gameState.undercoverCount,
                    color: const Color(0xFFf43f5e),
                    iconData: FontAwesomeIcons.userSecret,
                    onMinus: () => gameState.updateRoleCount('undercover', -1),
                    onPlus: () => gameState.updateRoleCount('undercover', 1),
                  ),
                  const SizedBox(height: 20),
                  _buildRoleRow(
                    title: loc.translate('mrwhite'),
                    subtitle: loc.translate('mrwhite_desc'),
                    count: gameState.mrWhiteCount,
                    color: const Color(0xFFfacc15),
                    iconData: FontAwesomeIcons.ghost,
                    onMinus: () => gameState.updateRoleCount('mrwhite', -1),
                  onPlus: () => gameState.updateRoleCount('mrwhite', 1),
                  ),
                  const SizedBox(height: 20),
                  _buildPunishmentToggle(context, gameState, loc),
                  const SizedBox(height: 40),
                  BrutalCard(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.white,
                    child: Text(
                      '${loc.translate("total_players")}${gameState.totalPlayers}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loc.translate('setup_recommendation'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  BrutalButton(
                    backgroundColor: const Color(0xFFa855f7),
                    onPressed: gameState.totalPlayers >= 3
                        ? () {
                            AnalyticsService().logEvent('setup_completed', parameters: {
                              'total_players': gameState.totalPlayers,
                              'civilian_count': gameState.civilianCount,
                              'undercover_count': gameState.undercoverCount,
                              'mrwhite_count': gameState.mrWhiteCount,
                            });
                            gameState.initializePlayers();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NamesScreen()),
                            );
                          }
                        : null,
                    child: Text(loc.translate('continue')),
                  ),
                  if (gameState.totalPlayers < 3)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                      child: Text(
                        loc.translate('need_3_players'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    const SizedBox(height: 36),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoleRow({
    required String title,
    required String subtitle,
    required int count,
    required Color color,
    required var iconData,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return BrutalCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: color,
      child: Row(
        children: [
          FaIcon(iconData, size: 36, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onMinus,
                icon: const FaIcon(FontAwesomeIcons.circleMinus, color: Colors.black, size: 28),
              ),
              SizedBox(
                width: 35,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: onPlus,
                icon: const FaIcon(FontAwesomeIcons.circlePlus, color: Colors.black, size: 28),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPunishmentToggle(BuildContext context, GameState gameState, LocalizationProvider loc) {
    return BrutalCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFFfb923c),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.translate('enable_punishment'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              Switch(
                value: gameState.isPunishmentEnabled,
                onChanged: (val) {
                  AnalyticsService().logEvent('punishment_toggled', parameters: {'enabled': val.toString()});
                  gameState.togglePunishment(val);
                  if (val) {
                    gameState.initDefaultPunishments([
                      loc.translate('default_punishment_1'),
                      loc.translate('default_punishment_2'),
                      loc.translate('default_punishment_3'),
                      loc.translate('default_punishment_4'),
                    ]);
                  }
                },
                activeColor: Colors.black,
                activeTrackColor: Colors.white,
              ),
            ],
          ),
          if (gameState.isPunishmentEnabled)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: BrutalButton(
                backgroundColor: Colors.white,
                onPressed: () => _showPunishmentEditor(context, gameState, loc),
                child: Text(loc.translate('edit_punishments'), style: const TextStyle(color: Colors.black)),
              ),
            ),
        ],
      ),
    );
  }

  void _showPunishmentEditor(BuildContext context, GameState gameState, LocalizationProvider loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _PunishmentEditorSheet(gameState: gameState, loc: loc);
      },
    );
  }
}

class _PunishmentEditorSheet extends StatefulWidget {
  final GameState gameState;
  final LocalizationProvider loc;

  const _PunishmentEditorSheet({required this.gameState, required this.loc});

  @override
  State<_PunishmentEditorSheet> createState() => _PunishmentEditorSheetState();
}

class _PunishmentEditorSheetState extends State<_PunishmentEditorSheet> {
  final TextEditingController _controller = TextEditingController();

  void _addPunishment() {
    if (_controller.text.trim().isNotEmpty) {
      AnalyticsService().logEvent('punishment_added');
      widget.gameState.addPunishment(_controller.text);
      _controller.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3),
        ),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.loc.translate('punishments'),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.gameState.customPunishments.length,
                itemBuilder: (context, index) {
                  return BrutalCard(
                    backgroundColor: const Color(0xFFf3f4f6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.gameState.customPunishments[index],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.trash, color: Colors.red),
                          onPressed: () {
                            AnalyticsService().logEvent('punishment_removed');
                            widget.gameState.removePunishment(index);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: widget.loc.translate('add_punishment'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    onSubmitted: (_) => _addPunishment(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _addPunishment,
                  icon: const FaIcon(FontAwesomeIcons.circlePlus, color: Colors.black, size: 36),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BrutalButton(
              backgroundColor: const Color(0xFF38bdf8),
              onPressed: () => Navigator.pop(context),
              child: Text(widget.loc.translate('close')),
            ),
          ],
        ),
      ),
    );
  }
}
