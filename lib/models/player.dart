class Player {
  final int id;
  String name;
  String role;
  String word;
  bool isAlive;

  Player({
    required this.id,
    required this.name,
    this.role = '',
    this.word = '',
    this.isAlive = true,
  });
}
