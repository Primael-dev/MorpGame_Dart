class Player {
  String _name;
  String _symbol;
  int _score;

  Player(this._name, this._symbol) : _score = 0;

  String getName() => _name;
  String getSymbol() => _symbol;
  int getScore() => _score;

  void incrementScore() {
    _score++;
  }

  void resetScore() {
    _score = 0;
  }

  @override
  String toString() => '$_name ($_symbol) - Score: $_score';
}