import 'package:flutter/foundation.dart';
import '../data/words.dart';
import 'player.dart';

class GameState extends ChangeNotifier {
  int civilianCount = 3;
  int undercoverCount = 1;
  int mrWhiteCount = 0;

  bool isPunishmentEnabled = false;
  List<String> customPunishments = [];

  List<Player> players = [];
  WordPair? currentWords;
  
  // Trạng thái Pass and Play
  int currentPlayerIndex = 0;

  // Trạng thái Speaking
  List<Player> speakingOrder = [];
  int currentSpeakingIndex = 0;

  int get totalPlayers => civilianCount + undercoverCount + mrWhiteCount;

  void updateRoleCount(String role, int change) {
    if (role == 'civilian' && civilianCount + change >= 1) {
      civilianCount += change;
    } else if (role == 'undercover' && undercoverCount + change >= 0) {
      undercoverCount += change;
    } else if (role == 'mrwhite' && mrWhiteCount + change >= 0) {
      mrWhiteCount += change;
    }
    notifyListeners();
  }

  void togglePunishment(bool value) {
    isPunishmentEnabled = value;
    notifyListeners();
  }

  void initDefaultPunishments(List<String> defaults) {
    if (customPunishments.isEmpty) {
      customPunishments = List.from(defaults);
      notifyListeners();
    }
  }

  void addPunishment(String punishment) {
    if (punishment.trim().isNotEmpty) {
      customPunishments.add(punishment.trim());
      notifyListeners();
    }
  }

  void removePunishment(int index) {
    if (index >= 0 && index < customPunishments.length) {
      customPunishments.removeAt(index);
      notifyListeners();
    }
  }

  void initializePlayers() {
    if (players.length == totalPlayers) {
      players.sort((a, b) => a.id.compareTo(b.id));
      return;
    }
    players = List.generate(
      totalPlayers,
      (index) => Player(id: index, name: 'Người chơi ${index + 1}'),
    );
    notifyListeners();
  }

  void updatePlayerName(int index, String name) {
    if (index >= 0 && index < players.length) {
      players[index].name = name;
      notifyListeners();
    }
  }

  void startGame(String lang, String defaultNamePrefix, String mrWhiteWordFallback) {
    // Phân bổ role
    List<String> rolePool = [];
    for (int i = 0; i < civilianCount; i++) { rolePool.add('civilian'); }
    for (int i = 0; i < undercoverCount; i++) { rolePool.add('undercover'); }
    for (int i = 0; i < mrWhiteCount; i++) { rolePool.add('mrwhite'); }

    rolePool.shuffle();

    // Lấy từ khóa ngẫu nhiên theo ngôn ngữ
    currentWords = WordsData.getRandomPair(lang);

    // Gán role và từ khóa cho người chơi
    for (int i = 0; i < players.length; i++) {
      players[i].role = rolePool[i];
      players[i].isAlive = true;
      if (players[i].name.isEmpty || players[i].name.startsWith('Người chơi') || players[i].name.startsWith('Player')) {
        players[i].name = '$defaultNamePrefix ${i + 1}';
      }
      
      if (players[i].role == 'civilian') {
        players[i].word = currentWords!.civilianWord;
      } else if (players[i].role == 'undercover') {
        players[i].word = currentWords!.undercoverWord;
      } else {
        players[i].word = mrWhiteWordFallback;
      }
    }

    // Xáo trộn thứ tự chuyền máy
    players.shuffle();
    currentPlayerIndex = 0;

    notifyListeners();
  }

  void nextPlayerTurn() {
    currentPlayerIndex++;
    notifyListeners();
  }

  bool isPassAndPlayFinished() {
    return currentPlayerIndex >= players.length;
  }

  Player get currentPlayer => players[currentPlayerIndex];

  List<Player> get alivePlayers => players.where((p) => p.isAlive).toList();

  void startSpeakingPhase() {
    speakingOrder = List.from(alivePlayers);
    speakingOrder.shuffle();

    // Ensure Mr. White is not the first speaker if there are other roles available
    if (speakingOrder.isNotEmpty && speakingOrder.first.role == 'mrwhite') {
      int nonMrWhiteIndex = speakingOrder.indexWhere((p) => p.role != 'mrwhite');
      if (nonMrWhiteIndex != -1) {
        final temp = speakingOrder[0];
        speakingOrder[0] = speakingOrder[nonMrWhiteIndex];
        speakingOrder[nonMrWhiteIndex] = temp;
      }
    }

    currentSpeakingIndex = 0;
    notifyListeners();
  }

  void nextSpeakingTurn() {
    currentSpeakingIndex++;
    notifyListeners();
  }

  bool isSpeakingPhaseFinished() {
    return currentSpeakingIndex >= speakingOrder.length;
  }

  Player get currentSpeaker => speakingOrder[currentSpeakingIndex];

  void eliminatePlayer(int id) {
    final playerIndex = players.indexWhere((p) => p.id == id);
    if (playerIndex != -1) {
      players[playerIndex].isAlive = false;
      notifyListeners();
    }
  }

  String checkWinCondition() {
    int aliveCivilians = players.where((p) => p.isAlive && p.role == 'civilian').length;
    int aliveUndercovers = players.where((p) => p.isAlive && p.role == 'undercover').length;
    int aliveMrWhites = players.where((p) => p.isAlive && p.role == 'mrwhite').length;

    if (aliveCivilians <= aliveUndercovers + aliveMrWhites) {
      if (aliveUndercovers > 0 && aliveMrWhites > 0) {
        return 'inf_win';
      } else if (aliveUndercovers > 0) {
        return 'undercover_win';
      } else {
        return 'mrwhite_win';
      }
    } else if (aliveUndercovers == 0 && aliveMrWhites == 0) {
      return 'civilian_win';
    } else {
      return 'continue';
    }
  }

  String _removeDiacritics(String str) {
    const withDia = 'áàảãạăắằẳẵặâấầẩẫậđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ';
    const withoutDia = 'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy';
    
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  bool checkMrWhiteGuess(String guess) {
    if (currentWords == null) return false;
    
    // Normalize words for comparison
    String civilianWord = _removeDiacritics(currentWords!.civilianWord.toLowerCase().trim());
    String userGuess = _removeDiacritics(guess.toLowerCase().trim());
    
    // Comparison
    return civilianWord == userGuess;
  }
}
