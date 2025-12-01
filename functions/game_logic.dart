import 'player.dart';
import 'board.dart';

class GameLogic {
  Player _player1;
  Player _player2;
  late Player _currentPlayer;
  late Board _board;
  bool _gameOver;
  Player? _winner;
  int _turnCount;

  GameLogic(this._player1, this._player2)
      : _gameOver = false,
        _turnCount = 0 {
    _board = Board();
    _currentPlayer = _player1;
  }

  void startNewGame() {
    _board.reset();
    _gameOver = false;
    _winner = null;
    _turnCount = 0;
    _currentPlayer = _player1;
  }

  void resetGame() {
    startNewGame();
    _player1.resetScore();
    _player2.resetScore();
  }

  bool playTurn(int row, int col) {
    if (_gameOver) return false;
    if (!_board.makeMove(row, col, _currentPlayer.getSymbol())) {
      return false;
    }
    _turnCount++;
    if (checkWinner()) {
      _gameOver = true;
      _winner = _currentPlayer;
      _currentPlayer.incrementScore();
      return true;
    }
    if (isDraw()) {
      _gameOver = true;
      return true;
    }
    switchPlayer();
    return true;
  }

  void switchPlayer() {
    _currentPlayer = (_currentPlayer == _player1) ? _player2 : _player1;
  }

  Player getCurrentPlayer() => _currentPlayer;

  bool checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (checkRow(i) || checkColumn(i)) return true;
    }
    return checkMainDiagonal() || checkAntiDiagonal();
  }

  bool checkRow(int row) {
    String first = _board.getCell(row, 0).getValue();
    if (first.isEmpty) return false;
    return first == _board.getCell(row, 1).getValue() &&
        first == _board.getCell(row, 2).getValue();
  }

  bool checkColumn(int col) {
    String first = _board.getCell(0, col).getValue();
    if (first.isEmpty) return false;
    return first == _board.getCell(1, col).getValue() &&
        first == _board.getCell(2, col).getValue();
  }

  bool checkMainDiagonal() {
    String first = _board.getCell(0, 0).getValue();
    if (first.isEmpty) return false;
    return first == _board.getCell(1, 1).getValue() &&
        first == _board.getCell(2, 2).getValue();
  }

  bool checkAntiDiagonal() {
    String first = _board.getCell(0, 2).getValue();
    if (first.isEmpty) return false;
    return first == _board.getCell(1, 1).getValue() &&
        first == _board.getCell(2, 0).getValue();
  }

  bool isGameOver() => _gameOver;

  bool isDraw() => _board.isFull() && !checkWinner();

  String getGameStatus() {
    if (!_gameOver) return 'En cours';
    if (_winner != null) return '${_winner!.getName()} a gagné!';
    return 'Match nul!';
  }

  Player? getWinner() => _winner;

  Board getBoard() => _board;

  int getTurnCount() => _turnCount;
}